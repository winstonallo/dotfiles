{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.docker
        pkgs.git
        pkgs.cargo
        pkgs.zsh
        pkgs.go
        pkgs.rustup
        pkgs.wget        
        pkgs.oh-my-zsh
    ];
    
    shellHook = ''
        if [ -f ~/.zshrc ]; then
            zsh
            source ~/.zshrc
        fi
        echo "you're all set! don't break anything today"
    '';
}
