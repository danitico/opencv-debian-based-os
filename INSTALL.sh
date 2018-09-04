# Creating folder to save source code of OpenCV
mkdir /home/$USER/OpenCV/

# Moving to OpenCV directory
cd /home/$USER/OpenCV/

# Downloading OpenCV's source code
wget --tries=2 --output-document=opencv.zip -q "https://codeload.github.com/opencv/opencv/zip/3.3.0"

# Unzip of opencv.zip
