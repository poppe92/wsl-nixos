{ 
  pkgs,
  ... 
}: {

  programs.zsh = {
	enable = true;
	shellAliases = {
		ls = "eza --icons=auto --color=auto";
		lst = "eza --tree --icons=auto --color=auto";
		ll = "eza -la --icons=auto --color=auto";
		cat = "bat --theme Dracula";
		whatsmypublicip = "curl -4L myip.0xa.se";
		# idea = "${pkgs.jetbrains.idea-ultimate}/idea-ultimate/bin/idea.sh \"$1\" > /dev/null 2>&1 &";
	};
	oh-my-zsh = {
		enable = true;
		theme = "af-magic";
		plugins = ["git" "mvn" "ag" "fzf" ];
	};
	syntaxHighlighting.enable = true;
        autosuggestion.enable = true;
	initExtra = ''
		fortune | cowsay | lolcat
	'';
  };

}
