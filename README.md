# PHP Convert HEIC 🎨

This repository serves to show how to enable HEIC support with ImageMagick through PHP's imagick extension.

## Running the example 🏃

First start the container 🐳

```
docker-compose up -d
```

Then run the PHP script 🐘

```
docker exec -it heic_app php convert.php
```

If successful, you should see a file named `IMG_8019.jpg` in the repository's root directory 🎉