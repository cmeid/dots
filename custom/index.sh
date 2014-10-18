# if you want to hook the installation to other dotfiles-type stuff, you can do it here

# install custom terminal

mkdir -p $custom/tmp
cd $custom/tmp
git clone git@github.com:agaridata/laptop-automation.git
open laptop-automation/terminal/*.terminal
defaults write com.apple.Terminal "Default Window Settings" -string "cmeid"
defaults write com.apple.Terminal "Startup Window Settings" -string "cmeid"
rm -rf $custom/tmp

# pull dotfiles
cd ~
git clone git@github.com:robbyrussell/oh-my-zsh.git 

mackup restore

# set zsh default
chsh -s `which zsh`
