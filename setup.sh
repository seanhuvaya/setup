#!/bin/bash

# Constants
GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

echo -e "${GREEN}Installing brew...${NO_COLOR}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo -e "${GREEN}Adding Homebrew to PATH...${NO_COLOR}"
echo >> /Users/$USER/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

echo -e "${GREEN}Installing item2...${NO_COLOR}"
brew install --cask iterm2

echo -e "${GREEN}Installing ohmyzsh...${NO_COLOR}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "${GREEN}Installing powerlevel10k theme...${NO_COLOR}"
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

echo -e "${GREEN}Installing Brave Browser...${NO_COLOR}"
brew install --cask brave-browser

echo -e "${GREEN}Installing Discord...${NO_COLOR}"
brew install --cask discord

echo -e "${GREEN}Installing Slack...${NO_COLOR}"
brew install --cask slack

echo -e "${GREEN}Installing PyCharm...${NO_COLOR}"
brew install --cask pycharm

echo -e "${GREEN}Installing uv...${NO_COLOR}"
brew install uv

echo -e "${GREEN}Installing Rectangle...${NO_COLOR}"
brew install --cask rectangle

echo -e "${GREEN}Installing Notion...${NO_COLOR}"
brew install --cask notion

echo -e "${GREEN}Installing Notion Calendar...${NO_COLOR}"
brew install --cask notion-calendar

echo -e "${GREEN}Installing Postman...${NO_COLOR}"
brew install --cask postman

echo -e "${GREEN}Installing Docker...${NO_COLOR}"
brew install --cask docker
