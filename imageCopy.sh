read -p "Please enter host address: " HOST
read -p "Please enter server username: " USERNAME

BASEDIR="$(git rev-parse --show-toplevel)"
read -p "Retrieve user upload files? (y/n): " GETPHOTOS
if [[ $GETPHOTOS == "y"* ]]; then
    if [ -d "$BASEDIR/public" ]; then
        rsync -rhv $USERNAME@$HOST:www/public_html/public/uploads $BASEDIR/public
    elif [ -d "./uploads" ]; then
        rsync -rhv $USERNAME@$HOST:www/public_html/public/uploads ./public
    else
        echo "Unable to find public directory to place images in the correct path. Please run this script from the root directory of the project or where the 'uploads' folder is located."
    fi
fi
