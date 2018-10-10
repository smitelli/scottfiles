Host github.com
    User git

    AddKeysToAgent yes
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_github.com_ed25519
    IdentityFile ~/.ssh/id_github.com_rsa
    IdentityFile ~/.ssh/id_github.com_ecdsa
    IdentityFile ~/.ssh/id_github.com_dsa
