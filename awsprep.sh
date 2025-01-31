if [ ! -d ~/eks-casa/ ]; then
  echo "Creating home directory ~/eks-casa/"
  mkdir ~/eks-casa/
fi

if [ ! -f ~/eks-casa/aws ]; then
  echo "Install AWS CLI"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -qq awscliv2.zip
  sudo ./aws/install --bin-dir ~/eks-casa/ --install-dir ~/eks-casa/ --update
  rm -rf awscliv2.zip aws
fi

if [ ! -f ~/eks-casa/eksctl ]; then
  echo "Install eksctl"
  # curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.132.0-rc.0/eksctl_Linux_amd64.tar.gz" | tar xz -C ~/eks-casa
  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C ~/eks-casa
  # curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.92.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C ~/eks-casa
fi

if [ ! -f ~/eks-casa/kubectl ]; then
  echo "Install kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  # curl -LO "https://dl.k8s.io/release/v1.23.1/bin/linux/amd64/kubectl"
  chmod 755 kubectl
  mv kubectl ~/eks-casa/
fi

if [ ! -f ~/eks-casa/helm ]; then
  echo "Install helm"
  wget https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz
  tar -zxvf helm-v3.7.0-linux-amd64.tar.gz
  mv linux-amd64/helm .
  rm helm-v3.7.0-linux-amd64.tar.gz
  rm -rf linux-amd64
  mv helm ~/eks-casa/
fi

cat ~/.bashrc | grep eks-casa >/dev/null

if [ `echo $?` -eq 1 ]
then
  echo "export PATH=$PATH:~/eks-casa" >> ~/.bashrc
  echo "alias k=~/eks-casa/kubectl" >> ~/.bashrc
fi

source ~/.bashrc

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Generate ssh public key"
  ssh-keygen -q -f ~/.ssh/id_rsa -N ""
fi

# clear

# aws sts get-caller-identity | grep assumed-role
# if [ `echo $?` -eq 1 ]
# then
  # echo -n "Enter your AWS Access Key ID and press [ENTER]: "
  # read AWS_ACCESS_KEY_ID
  # echo "" | awk '{print $1}'
  # echo $AWS_ACCESS_KEY_ID > awsaccess
  # echo -n "Enter your AWS Secret Access Key and press [ENTER]: "
  # read AWS_SECRET_ACCESS_KEY
  # echo $AWS_SECRET_ACCESS_KEY >> awsaccess
# fi

echo "" | awk '{print $1}'
echo "You are ready to deploy now!"
echo "" | awk '{print $1}'

echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'
