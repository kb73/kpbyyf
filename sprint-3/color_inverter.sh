if [ "$1" = "" ]; then echo "Please specify a directory"
else
	echo $1
	for f in $(find "$1" -name '*.png'); do
		convert $f -channel RGB -negate $f
	done
fi
