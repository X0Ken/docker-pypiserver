## Pypi in docker
This project help you start a Pypi

## How to use it

### Create a password file
```bash
# install htpasswd
apt-get install apache2-utils

# create password
htpasswd -sc htpasswd.txt your-name
```

### Start server
```bash
docker build . -t pypiserver
docker run -p8000:8000 pypiserver
```

### Download package
```bash
## Download and Install hosted packages.
pip install  --extra-index-url http://localhost:8000/simple/ ...

## Search hosted packages
pip search --index http://localhost:8000/simple/ ...
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