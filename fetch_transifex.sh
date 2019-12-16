#!/bin/bash

if [ -v CI ]; then
  echo -e "Running in CI environment"
  git status
  echo -e "\n"
  ls -lah
else
  echo -e "\nPlease run in the root directory of the repository!\n"
  echo -e "We are going to delete current old deployed files, please check below for your git status...\n"
  sleep 0.5
  git status
  echo -e "\n"
  ls -lah
  echo -e "\n\nIf everything looks fine, press any key to continue..."
  read
fi

rm -rv advanced app basics en_US prep README.md resource routing

echo -e "\nStart fetching from remote transifex branch..."
git fetch origin transifex --progress

echo -e "\nStart checking out files..."
git checkout origin/transifex -- zh_CN
git checkout origin/transifex -- en_US
git checkout origin/transifex -- fa
git checkout origin/transifex -- ko_KR
git checkout origin/transifex -- ru_RU
git checkout origin/transifex -- vi_VN
git checkout origin/transifex -- fr_FR


mv -v zh_CN/* ./
rmdir -v zh_CN

echo -e "If no errors prompted, zh_CN folder should already been deleted, and all files are located at root directory."
echo -e "You can now run deploy.sh if needed."
