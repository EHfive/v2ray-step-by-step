#!/bin/bash

DEFAULT_DEPLOY_REPO=git@github.com:v2fly/v2ray-step-by-step.git

if [ -v DEPLOY_REPO ]; then
  _deploy_repo=$DEPLOY_REPO
else
  _deploy_repo=$DEFAULT_DEPLOY_REPO
fi

echo -e "Start building..."
vuepress build .

if [ -v CI ]; then
  echo -e "Running in CI environment"
else
  echo -e "\n\nCheck if build prompted any errors.\nPress any key to countinue..."
  read
fi

cd .vuepress/dist
echo "guide.v2fly.org" > CNAME
git init
git config user.name V2FlyContrib
git config user.email SharedAccount+V2FlyContrib@unial.org
git config commit.gpgsign false
git add -A
git commit -m "build $(date -u '+#%U%g%w-%N')"
git push -f -v --progress ${_deploy_repo} master:gh-pages
cd ../
rm -rfv dist/
echo "Done."
