#### Mengubah Secret

Terdapat dua cara untuk mengubah secrets. Bisa dengan mengubah value dari file YAML atau dengan memanfaatkan perintah `--dry-run` pada kubectl

Mengubah secret menggunakan kubectl dapat dilakukan dengan perintah

```{.bash .copy}
kubectl create secret generic mysecret --from-literal=password=newsecretpassword --dry-run=client -o yaml | kubectl apply -f -
```

Untuk mengubah Secret menggunakan YAML, pertama kita perlu membuat file YAML dari secret `mysecret`. Jalankan perintah berikut

```{.bash .copy}
kubectl get secret mysecret -o yaml > /home/admin/mysecret.yml
```

Selanjutnya encode value baru untuk secret menggunakan perintah

```{.bash .copy}
echo newpassword | base64
```

Lalu ubah value pada file YAML menggunakan encoded password, lalu jalankan perintah `apply`

```{.bash .copy}
kubectl apply -f mysecret.yml
```

**Perhatian**: Perubahan pada Secret tidak otomatis mengubah config pada Pod, diperlukan restart untuk bisa menerima update.

Restart pada Pod dapat dilakukan dengan mengubah isi dari file YAML Pod lalu meng-apply perubahan tersebut dengan perintah

```
kubectl apply -f pod.yml
```

#### Menghapus Secret

Menghapus Secret dapat mengakibatkan error pada resource yang menggunakannya, seperti Pod ataupun Deployment. Pastikan semua resource tadi sudah tidak menggunakan Secret yang akan dihapus.

Menghapus Secret dapat dilakukan dengan menjalankan perintah berikut:

```{.bash .copy}
kubectl delete secret mysecret
```
