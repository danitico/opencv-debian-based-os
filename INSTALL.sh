# Installing required packages for OpenCV via apt-get
echo "INSTALLING REQUIRED PACKAGES"
echo "----------------------------"
sudo apt --yes install build-essential cmake git libgtk2.0-dev 'pkg-config' libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev gcc-multilib g++-multilib

if [[ $? > 0 ]]; then
	echo "It seems that you are having problems with apt"
	echo "Stopping script ..."
	exit
fi

echo "Creating the directory which has the source code"
echo "------------------------------------------------"
# Creating folder to save source code of OpenCV
if [ ! -e /home/$USER/OpenCV/ ]; then
	mkdir /home/$USER/OpenCV/
else
	echo "Folder is already created"
	rm -rf /home/$USER/OpenCV/*
fi

# Moving to OpenCV directory
cd /home/$USER/OpenCV/

# Downloading OpenCV's source code
if [ ! -e opencv.zip ]; then
	echo "Downloading source code"
	echo "-----------------------"
	wget --tries=2 --output-document=opencv.zip -q "https://codeload.github.com/opencv/opencv/zip/3.3.0"
	wget --tries=2 --output-document=modules.zip -q "https://github.com/opencv/opencv_contrib/archive/3.3.0.zip"
else
	find . ! -name 'opencv.zip' -exec rm -rf {} + 2> /dev/null
fi

# Extracting opencv.zip quietly
echo "EXTRACTING SOURCE CODE"
echo "--------------"
unzip -q opencv.zip

# Erasing useless directory and zip file
cd opencv-3.3.0/
mv * ../
cd ../
rm -rf opencv-3.3.0/

# Extracting modules.zip quietly
echo "EXTRACTING CONTRIBUTORS SOURCE CODE"
echo "------------------"
unzip -q modules.zip

#Erasing zip file and renaming directory
mv opencv_contrib-3.3.0/ opencv_contrib/

# Creating temporary directory
mkdir build
cd build/

echo "RUNNING CMAKE"
echo "-------------"
# Running Cmake [PARAMETERS*] path_source_code
cmake -DCMAKE_BUILD_TYPE=Release -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules -DCMAKE_INSTAL_PREFIX=/usr/local ../

# Once we run cmake, we have the files to build OpenCV. In the directory
# /opencv/build , we run make using threads.
echo "BUILDING OPENCV"
echo "---------------"
make -j8

# When OpenCV is built, we install the libraries of it
echo "INSTALLING LIBRARIES"
echo "--------------------"
sudo make install
echo "LIBRARIES HAVE BEEN INSTALLED"

# When the libraries have been installed, we have to tell to
# ldconfig(It configures the dynamic linker run-time bindings)
# that we have shared libraries in /usr/local/lib (where the
# libraries have been installed
echo "RUNNING LDCONFIG"
echo "----------------"
sudo echo "/usr/local/lib/" > opencv.conf
sudo ldconfig

echo "ALL HAVE BEEN INSTALLED"
