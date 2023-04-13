#### Apa Itu Secret

Kubernetes Secrets adalah sebuah obyek yang digunakan untuk menyimpan informasi sensitif seperti password, token, atau kunci API. Secrets dikelola oleh Kubernetes dan dapat digunakan oleh Pod yang berjalan di dalam cluster.

Ada dua jenis Secrets di Kubernetes: generic dan TLS. Generic Secret digunakan untuk menyimpan key-value pairs, sedangkan TLS Secret digunakan untuk menyimpan kunci dan sertifikat TLS.

Seperti halnya ConfigMap, Secrets juga dapat digunakan dalam container dengan dua cara: sebagai environment variable atau sebagai file di dalam volume.

Untuk membuat Secret, kita dapat menggunakan perintah kubectl create secret. Untuk menggunakan Secret di dalam Pod, kita dapat menggunakan referensi Secret di dalam file YAML Pod.

#### Struktur YAML

```{.yaml}
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
data:
  username: dXNlcm5hbWU=
  password: cGFzc3dvcmQ=
```

Pada file YAML di atas, terdapat sebuah Secret dengan nama mysecret.

Dalam secret diatas terdapat key-value pairs untuk `username` dan `password`. Value dari key-value pairs tersebut telah diencode menggunakan base64. Dalam contoh ini, value dari username adalah `username` yang telah diencode menjadi `dXNlcm5hbWU=` dan nilai dari password adalah `password` yang telah diencode menjadi `cGFzc3dvcmQ=`.
