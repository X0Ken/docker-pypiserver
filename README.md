## Pypi Server in docker
This project help you start a Pypi Server in a easy way.

## How to use it

### Create a password file
If you do not need to upload, you just `touch htpasswd.txt`, then skip this section.
```bash
# install htpasswd
apt-get install apache2-utils

# create password
htpasswd -sc htpasswd.txt your-name
```

### Start server
```bash
docker build . -t pypiserver
docker run -d -p 8000:8000 --restart always pypiserver
```

### Start server with local storage
```bash
docker build . -t pypiserver
docker run -d -p 8000:8000 \
    -v /opt/data:/root/packages \
    --restart always pypiserver

# You can use pip download to fast fill storage
cd /opt/data
pip download ...
```

### Download package
```bash
## Download and Install hosted packages.
pip install  -i http://localhost:8000 ...

## Search hosted packages
pip search --index http://localhost:8000 ...
```

### Upload package
```bash
# create .pypirc
cat >> ~/.pypirc <<EOF
[distutils]
index-servers =
  pypi
  local

[pypi]
username:<your_pypi_username>
password:<your_pypi_passwd>

[local]
repository: http://localhost:8000
username: <your-name>
password: <your-passwd>
EOF

# upload package
python setup.py sdist upload -r local
```
Note: The `<your-name>` and `<your-passwd>` must in `htpasswd.txt`

Now you can enjoy it.
