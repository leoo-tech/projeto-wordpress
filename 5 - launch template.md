# 🚀 Etapa 5: Criando o Launch Template

O Launch Template é o "molde" ou "blueprint" para nossas instâncias EC2. Ele define qual sistema operacional, tipo de instância, configurações de rede e scripts de inicialização serão usados toda vez que o Auto Scaling Group precisar criar uma nova instância. É aqui que a mágica da automação acontece.

> **🎯 Objetivo do Launch Template:**
> * Definir um padrão para a criação de instâncias EC2.
> * Automatizar a instalação do Docker e a configuração do WordPress através de um script `user_data`.
> * Garantir que toda nova instância seja idêntica e se configure sozinha, pronta para receber tráfego.

---

### 🔹 Passo 1: Iniciar a Criação do Launch Template

1.  No Console da AWS, navegue até **EC2 > Launch Templates**.
2.  Clique em **Create launch template**.

---

### 🔹 Passo 2: Configurações Básicas

1.  **Launch template name**: Dê um nome ao seu template. Ex: `wordpress-template`.
2.  **Template version description**: Forneça uma breve descrição. Ex: `Versão inicial do template para WordPress`.
3.  **Amazon Machine Image (AMI)**: Selecione a AMI **Amazon Linux 2023**.
4.  **Instance type**: Escolha **t2.micro**, que se qualifica para a camada gratuita da AWS.
5.  **Key pair (login)**: **Não** selecione um par de chaves. O acesso será gerenciado de forma segura pelo Session Manager da AWS, e as instâncias devem ser automatizadas, não acessadas manualmente.

<img src="/imgs/Nome%20e%20descrição%20do%20modelo%20de%20execução.png" alt="Configurações Básicas do Launch Template">
<img src="/imgs/imagens%20do%20sistema.png" alt="Seleção de AMI e Tipo de Instância">

---

### 🔹 Passo 3: Configurações de Rede

1.  **Subnet**: **Não** selecione uma sub-rede. Deixe este campo em branco, pois o Auto Scaling Group será responsável por escolher as sub-redes privadas corretas para lançar as instâncias.
2.  **Security groups**: Selecione **`ec2-sg`**. Este é o único Security Group que deve ser anexado diretamente às instâncias. Ele já possui as regras necessárias para se comunicar com o Load Balancer, EFS e RDS.

<img src="/imgs/configRedes.png" alt="Configurações de Rede do Launch Template">

---

### 🔹 Passo 4: Configuração do User Data

Esta é a seção mais importante. No campo **User data**, cole o script abaixo. Ele automatiza toda a configuração da instância.

> ⚠️ **Atenção!**
> Antes de colar, você precisará substituir os valores placeholders (`<..._ENDPOINT>`, `<DB_USER>`, etc.) pelas informações reais dos seus serviços RDS e EFS que você anotou nas etapas anteriores.

```bash
#!/bin/bash
# Redireciona toda a saída para um arquivo de log para facilitar a depuração
exec > /var/log/user-data.log 2>&1
# Interrompe o script se qualquer comando falhar
set -euxo pipefail

# --- Instalação do Docker e Docker Compose ---
dnf update -y
dnf install -y docker
systemctl enable --now docker
usermod -aG docker ec2-user

mkdir -p /usr/libexec/docker/cli-plugins
curl -SL "[https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64](https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64)" -o /usr/libexec/docker/cli-plugins/docker-compose
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# --- Montagem do EFS ---
mkdir -p /mnt/efs
# Substitua <EFS_ENDPOINT> pelo DNS Name do seu EFS
sudo mount -t nfs4 -o nfsvers=4.1 <EFS_ENDPOINT>:/ /mnt/efs

# Loop para garantir que o EFS foi montado antes de continuar
while ! mountpoint -q /mnt/efs; do
  sleep 2
done

# --- Configuração de Permissões e Arquivos do WordPress ---
mkdir -p /mnt/efs/wordpress
# Define o usuário www-data (ID 33) como dono para que o WordPress possa escrever arquivos
sudo chown -R 33:33 /mnt/efs/wordpress

# Cria o arquivo docker-compose.yaml com as configurações do WordPress
# Substitua os placeholders do RDS pelos seus valores
sudo -u ec2-user bash -c 'cat > /home/ec2-user/docker-compose.yaml <<EOF
version: "3.8"
services:
  wordpress:
    image: wordpress
    restart: always
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: <RDS_ENDPOINT>
      WORDPRESS_DB_USER: <DB_USER>
      WORDPRESS_DB_PASSWORD: <DB_PASSWORD>
      WORDPRESS_DB_NAME: <DB_NAME>
    volumes:
      - /mnt/efs/wordpress:/var/www/html
EOF'

# --- Inicia o Container do WordPress ---
sudo -u ec2-user bash -c "cd /home/ec2-user && docker compose up -d"
```

<img src="/imgs/Detalhes%20avançados.png" alt="Campo User Data">

---

### 🔹 Passo 5: Criar o Template

Após preencher todas as informações, clique em **Create launch template**.

### 📌 Resultado Esperado

Ao final desta etapa, você terá um Launch Template completo e reutilizável. Este "molde" contém toda a inteligência necessária para criar, de forma 100% automatizada, uma nova instância WordPress perfeitamente configurada e pronta para ser adicionada ao seu ambiente de alta disponibilidade.