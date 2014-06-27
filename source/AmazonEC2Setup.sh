# Set up RStudio and JAGS on an Amazon EC2 instance
# Using Ubuntu 64-bit
# Partially from http://blog.yhathq.com/posts/r-in-the-cloud-part-1.html 
# See yhat for EC2 instance set up

# Navigate to key pair
# ssh -i YOUR_KEYPAIR.pem ubuntu@ PUBLIC DNS

# Add a user
sudo adduser name

# Get all programs up to date
sudo apt-get update

# Install R and JAGSS
sudo add-apt-repository ppa:marutter/rrutter
sudo apt-get install r-base-dev jags r-cran-rjags

# Check that you have the latest R instal
## see also: http://askubuntu.com/a/352438
sudo apt-get update
apt-cache showpkg r-base

sudo apt-get install -f r-base= PACKAGE_VERSION

# Install git
sudo apt-get install git

sudo apt-get update

# Configure git
git config --global user.name USER_NAME
git config --global user.email USER_EMAIL

# Install RStudio
## for latest version of RStudio see http://www.rstudio.com/ide/download/server
sudo apt-get install gdebi-core
sudo apt-get install libapparmor1
wget http://download2.rstudio.org/rstudio-server-0.98.945-amd64.deb
sudo gdebi rstudio-server-0.98.945-amd64.deb

# Verify RStudio installation
sudo rstudio-server verify-installation

# Give all users read/write permissions of home directory.
# This is where Rstudio server looks.
# If you want to use the home directory for your repositories. 
## Warning: you might not want to give such permissive permissions
sudo chmod -R 0777 /home


# Access with http:// PUBLIC DNS :8787
