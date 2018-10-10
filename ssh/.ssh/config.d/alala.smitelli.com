Host alala.smitelli.com
    AddKeysToAgent yes
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_alala.smitelli.com_ed25519
    IdentityFile ~/.ssh/id_alala.smitelli.com_rsa
    IdentityFile ~/.ssh/id_alala.smitelli.com_ecdsa
    IdentityFile ~/.ssh/id_alala.smitelli.com_dsa
