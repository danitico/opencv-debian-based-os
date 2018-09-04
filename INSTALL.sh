# Installing required packages for OpenCV via apt-get
echo "INSTALLING REQUIRED PACKAGES"
sudo apt-get --yes install build-essential
sudo apt-get --yes install cmake git libgtk2.0-dev 'pkg-config' libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get --yes install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev

# Creating folder to save source code of OpenCV
mkdir /home/$USER/OpenCV/

# Moving to OpenCV directory
cd /home/$USER/OpenCV/

# Downloading OpenCV's source code
wget --tries=2 --output-document=opencv.zip -q "https://codeload.github.com/opencv/opencv/zip/3.3.0"

# Extracting opencv.zip
unzip -q opencv.zip

# Erasing useless directory and zip file
cd opencv-3.3.0/
mv * ../
cd ../
rm -rf opencv-3.3.0/ opencv.zip

# Creating temporary directory
mkdir build
cd build/

# Running Cmake [PARAMETERS*] path_source_code
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTAL_PREFIX=/usr/local ../

# Once we run cmake, we have the files to build OpenCV. In the directory
# /opencv/build , we run make using threads.
make -j6

# When OpenCV is built, we install the libraries of it
sudo make install

# When the libraries have been installed, we have to tell to
# ldconfig(It configures the dynamic linker run-time bindings)
# that we have shared libraries in /usr/local/lib (where the 
# libraries have been installed
sudo echo "/usr/local/lib/" > opencv.conf



