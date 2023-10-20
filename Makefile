setup: brew-install zsh-plugins symlink post-brew-install

zsh-plugins:
	./scripts/zsh-plugins.sh

brew-install:
	brew bundle install

symlink:
	./scripts/symlink.sh

post-brew-install:
	./scripts/post-brew-install.sh
