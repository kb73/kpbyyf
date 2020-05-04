# google-client-app
Flask, Flask-Login, Login with Google, App setup as Google Client

Installation with Pipenv:

```
pipenv install
```

Installation without Pipenv:

```
pip install -r requirements.txt
```

Export Google Client ID and Google Client Secret:

```
export GOOGLE_CLIENT_ID=<id>
export GOOGLE_CLIENT_SECRET=<secret>
```

Initalize the database by running app.py for the first time:

```
python3 app.py
```

Should see "Initialized the database."

Run the command again to start the Flask web server locally:

```
python3 app.py
```
