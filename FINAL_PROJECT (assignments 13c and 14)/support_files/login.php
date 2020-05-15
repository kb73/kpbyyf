<?php

    $credentials_file = fopen("/Users/kevinbowers/bitbar_plugins/support_files/credentials", 'r') or die("Unable to open file!");
    $output = fopen("/Users/kevinbowers/bitbar_plugins/support_files/output", "w+") or die("Unable to open output");

    $client_id = rtrim(fgets($credentials_file));
    $client_secret = rtrim(fgets($credentials_file));

    fclose($credentials_file);

    $metadata = http('https://dev-396932.okta.com/oauth2/default/.well-known/oauth-authorization-server');

    $ip = '127.0.0.1';
    $port = '8080';

    $redirect_uri = 'http://localhost:'.$port.'/authorization-code/callback';
    $socket_str = 'tcp://'.$ip.':'.$port;

    function http($url, $params=false) {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        if($params)
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($params));
        return json_decode(curl_exec($ch));
    }

    $state = bin2hex(random_bytes(5));

    $authorize_url = $metadata->authorization_endpoint.'?'.http_build_query([
        'response_type' => 'code',
        'scope' => 'openid',
        'client_id' => $client_id,
        'redirect_uri' => $redirect_uri,
        'state' => $state,
      ]);

    shell_exec("open '".$authorize_url."'");

    function startHttpServer($socketStr) {
        // Adapted from http://cweiske.de/shpub.htm
      
        $responseOk = "HTTP/1.0 200 OK\r\n"
          . "Content-Type: text/plain\r\n"
          . "\r\n"
          . "Ok. You may close this tab and return to the shell.\r\n";
        $responseErr = "HTTP/1.0 400 Bad Request\r\n"
          . "Content-Type: text/plain\r\n"
          . "\r\n"
          . "Bad Request\r\n";
      
        ini_set('default_socket_timeout', 7);
      
        $server = stream_socket_server($socketStr, $errno, $errstr);
      
        if(!$server) {
          Log::err('Error starting HTTP server');
          return false;
        }
      
        do {
          $sock = stream_socket_accept($server);
          if(!$sock) {
            // echo "Invalid credentials";
            exit(1);
          }
          $headers = [];
          $body    = null;
          $content_length = 0;
          //read request headers
          while(false !== ($line = trim(fgets($sock)))) {
            if('' === $line) {
              break;
            }
            $regex = '#^Content-Length:\s*([[:digit:]]+)\s*$#i';
            if(preg_match($regex, $line, $matches)) {
              $content_length = (int)$matches[1];
            }
            $headers[] = $line;
          }
          // read content/body
          if($content_length > 0) {
            $body = fread($sock, $content_length);
          }
          // send response
          list($method, $url, $httpver) = explode(' ', $headers[0]);
          if($method == 'GET') {
            #echo "Redirected to $url\n";
            $parts = parse_url($url);
            #print_r($parts);
            if(isset($parts['path']) && $parts['path'] == '/authorization-code/callback'
              && isset($parts['query'])
            ) {
              parse_str($parts['query'], $query);
              if(isset($query['code']) && isset($query['state'])) {
                fwrite($sock, $responseOk);
                fclose($sock);
                return $query;
              }
            }
          }
          fwrite($sock, $responseErr);
          fclose($sock);
        } while (true);
      }

    $auth = startHttpServer($socket_str);

    if($auth['state'] != $state) {
        echo "Wrong 'state' parameter returned\n";
        exit(2);
    }
      
    $code = $auth['code'];

    $response = http($metadata->token_endpoint, [
        'grant_type' => 'authorization_code',
        'code' => $code,
        'redirect_uri' => $redirect_uri,
        'client_id' => $client_id,
        'client_secret' => $client_secret,
    ]);

    if(!isset($response->access_token)) {
        echo "Error fetching access token\n";
        exit(2);
    }

    $access_token = $response->access_token;

    $token = http($metadata->introspection_endpoint, [
      'token' => $access_token,
      'client_id' => $client_id,
      'client_secret' => $client_secret,
    ]);
    
    if($token->active == 1) {
        fwrite($output,"pass");
      echo "Logged in as ".$token->username."\n";
      die();
    }    

    fclose($output);
?>