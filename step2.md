#### Membuat Secrets

Langkah pertama dalam mengelola secrets di Kubernetes adalah membuat secret. Pada langkah ini, kita akan membuat secret menggunakan perintah kubectl create secret.

```{.bash .copy}
kubectl create secret generic mysecret --from-literal=password=secretpassword
```

Pada perintah di atas, kita membuat sebuah secret generic dengan nama mysecret dan key-value pairs password=secretpassword.

#### Membaca Secrets

Tampilkan secrets yang telah dibuat dengan perintah berikut

```{.bash .copy}
kubectl get secrets mysecret -o yaml
```

Perhatikan password pada output, valuenya telah berubah menjadi base64 encoded.

```{.yaml}
apiVersion: v1
data:
  password: c2VjcmV0cGFzc3dvcmQ=
kind: Secret
metadata:
  creationTimestamp: "2023-04-09T07:21:34Z"
  name: mysecret
  namespace: default
  resourceVersion: "45460"
  uid: 45ac4187-9115-4b00-990b-fd4f7fb527e9
type: Opaque
```

Untuk membaca value dari secret kita bisa menggunakan command `base64` seperti dibawah, baik untuk mendecode maupun men-encode

Decode

```{.bash .copy}
echo c2VjcmV0cGFzc3dvcmQ= | base64 --decode
```

Encode

```{.bash .copy}
echo secretpassword | base64
```

#### Menggunakan Secret Env Pada Pod

Setelah berhasil membuat Secret, kita dapat menggunakan Secret pada resource Kubernetes seperti Pod.

Untuk menggunakan Secret pada Pod, buat file `pod.yaml` dan tambahkan konfigurasi berikut di dalam definisi Pod:

```{.yaml .copy}
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: example-container
    image: nginx
    env:
    - name: MYSQL_PASSWORD
      valueFrom:
        secretKeyRef:
          name: mysecret
          key: password
```

Konfigurasi di atas akan membuat sebuah Pod dengan nama `example-pod` yang menggunakan Secret `mysecret`.

Kemudian, jalankan perintah berikut untuk membuat Pod:

```{.bash .copy}
kubectl create -f pod.yaml
```

Mari cek apakah Secret password berhasil ditambahkan pada environment variable pada Pod. Tunggu hingga Pod berjalan lalu eksekusi perintah berikut

```{.bash .copy}
kubectl exec example-pod -- env | grep MYSQL_PASSWORD
```

Perintah diatas akan menampilkan value dari `MYSQL_PASSWORD` yaitu

```{.txt}
secretpassword
```

#### Menggunakan Secret File Pada Pod

Buat file baru dengan nama `pod-2.yml` lalu tambahkan konfigurasi seperti dibawah.

```{.yaml .copy}
apiVersion: v1
kind: Pod
metadata:
  name: example-pod-2
spec:
  containers:
  - name: example-container
    image: nginx
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/mysecret
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: mysecret
```

Konfigurasi di atas akan membuat sebuah Pod dengan nama `example-pod-2` yang membuat file baru pada `/etc/mysecret` yang berisi config dari `mysecret`

```{.bash .copy}
kubectl create -f pod-2.yaml
```

Lalu cek file pada Pod menggunakan perintah berikut

```{.bash .copy}
kubectl exec example-pod-2 -- cat /etc/mysecret/password
```

```{.bash}
secretpassword
```
