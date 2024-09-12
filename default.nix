{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.docker
        pkgs.git
        pkgs.neovim
        pkgs.cargo
        pkgs.zsh
        pkgs.go
        pkgs.rustup
        pkgs.wget        
        pkgs.oh-my-zsh
        pkgs.sqlite
        pkgs.gcc
        pkgs.pkg-config
    ];
    
    shellHook = ''
        if [ -n "$ZSH_VERSION" ]; then
            echo "launching zsh"
        else
            exec zsh
        fi
        export CGO_CFLAGS="-I${pkgs.sqlite.dev}/include"
        export CGO_LDFLAGS="-L${pkgs.sqlite.dev}/lib"
        export GOFLAGS="-tags=sqlite_omit_load_extension,libsqlite3"
    '';
}
