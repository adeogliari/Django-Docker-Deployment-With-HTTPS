
# Django com Docker Compose, NGINX e Let's Encrypt

Essa é uma base criada para auxiliar o desenvolvimento de projetos Django. Esta estrutura combina o Django, NGINX, Let's Encrypt e Certbot em containers Docker, permitindo uma implementação flexível e escalável.

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

## Índice


## Arquitetura

### Estrutura do docker
#### Serviços:
- **app**: O núcleo da aplicação Django.
- **certbot**: Encarregado de gerir os certificados SSL via Let's Encrypt.
- **proxy**: NGINX atuando como servidor proxy reverso.
- **db**: Banco de dados Postgres.

#### Volumes:
- **static-data**: Utilizado para armazenar dados estáticos do Django.
- **postgres-data**: Mantém os dados persistentes do banco de dados Postgres.
- **certbot-web** e **certbot-certs**: Relacionados ao armazenamento de informações e certificados SSL do Certbot.
- **proxy-dhparams**: Utilizado pelo serviço de proxy.

#### Redes:
- **django_net**: Rede bridge utilizada para a comunicação entre os serviços.

### Estrutura de pastas do Django
```
| app
	|-- core
	|-- aplicação
		|-- static
			|-- css
			|-- js
			|-- imgs
			|-- svg
			|-- font
			|-- video
		|-- templates
			|-- aplicação
	|-- static
		|-- css
		|-- js
		|-- imgs
		|-- svg
		|-- font
		|-- video
	|-- templates
```

## Recursos

- **Criação de certificado com Let's Encrypt**: Configuração automática de certificado SSL para garantir comunicações seguras.
- **Database local ou remota**: Flexibilidade para conectar-se a bancos de dados locais ou externos com suporte a Postgres.
- **Proxy Reverso com NGINX**: Configuração pronta para balanceamento de carga e roteamento de tráfego.
- **Configuração modular com Docker Compose**: Facilita a orquestração e o deploy de serviços relacionados.
- **Django Environment-ready**: Variáveis de ambiente preparadas para configuração rápida da aplicação Django.
- **Persistência de dados**: Volumes Docker configurados para persistência de dados do banco e arquivos estáticos.
- **Segurança**: Configuração de rede isolada para comunicação entre serviços e medidas de segurança adicionais para o banco de dados.

## Configuração Inicial (LINUX)

### Requisitos:
- GIT - [Como instalar](https://git-scm.com/book/pt-br/v2/Come%C3%A7ando-Instalando-o-Git)
- Docker - [Como Instalar](https://docs.docker.com/desktop/install/linux-install/)
- Editor de códigos ou IDE compatível com Python

### Preparando o projeto
#### 1 - Clone este repositório

#### 2 - Acesse a pasta do projeto e exclua a pasta .git
```bash
cd django_https && sudo rm -r .git
```

#### 3 - Copie o arquivo .env.sample para .env e defina as variáveis de ambiente
```bash
cp .env.sample .env && nano .env
```

## Variáveis de Ambiente

Este projeto foi planejado para trabalhar com variáveis de ambientes tanto para desenvolvimento quanto para deploy em produção. Abaixo estão as variáveis e suas descrições

```py
# Configurações de Segurança
DJANGO_SECRET_KEY=devsecretkey # Necessário em produção ou se o debug for 0
DJANGO_ALLOWED_HOSTS=127.0.0.1 # IPs ou domínios separados por "," (127.0.0.1,domain.example.com)
DJANGO_DEBUG=1 # 0 = false / 1 = true

# Configuração do banco de dados
DB_HOST=db # Use o IP, Endpoint ou nome do container
DB_PORT=5432 # Porta de conexão
DB_NAME=dbname # Nome do schema
DB_USER=dbuser # Usuário
DB_PASS=dbuserpass # Senha

# Configuração do SSL para habilitar HTTPS
DOMAIN=domain.example.com # Usado para gerar o certificado para o SSL e Definir o CSRF_TRUSTED_ORIGINS
ACME_DEFAULT_EMAIL=email@domain.example.com # Usado para gerar o certificado para o SSL

```

## Iniciando um projeto

No ambiente de desenvolvimento nós trabalhamos apenas com os serviços **app** e **db**

### Iniciando o git
```bash
git init
```

### Montando as imagens dos services
```bash
docker compose -f docker-compose.dev.yml build
```

### Iniciando os containers das imagens
```bash
docker compose -f docker-compose.dev.yml up
```

Ao subir os containers, o container do **app** irá primeiro aguardar a conexão com o banco de dados, quando a conexão for completada ele irá executar os comandos collect static e migrate gerando os arquivos estáticos e também criando a primeira versão do banco de dados.

### Criando as aplicações
```bash
docker compose -f docker-compose.dev.yml run --rm app sh -c 'python manage.py startapp nome_django_app'
```

### Criando django superuser
```bash
docker compose -f docker-compose.dev.yml run --rm app sh -c 'python manage.py createsuperuser'
```

## Outros comandos

### Criando Migrations
```bash
docker compose -f docker-compose.dev.yml run --rm app sh -c 'python manage.py makemigrations'
```

### Gerando django secret key
```bash
docker compose -f docker-compose.dev.yml run --rm app sh -c 'python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"'
```








