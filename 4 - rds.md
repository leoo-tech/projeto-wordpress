# 🗄️ Etapa 4: Criação do Banco de Dados (RDS)

Nesta etapa, vamos provisionar o coração da nossa aplicação: um banco de dados MySQL gerenciado pelo serviço AWS RDS. Isso nos dá a segurança e a persistência necessárias para todos os dados do WordPress, como posts, páginas e usuários.

> **🎯 Objetivo do RDS:**
> * Ter um banco de dados MySQL gerenciado, seguro e escalável.
> * Separar a camada de dados da camada de aplicação (EC2), seguindo as boas práticas de arquitetura.
> * Garantir que a conexão com o banco de dados seja privada e restrita apenas às nossas instâncias.

---

### 🔹 Passo 1: Iniciar a Criação do Banco de Dados

1.  No Console da AWS, na barra de busca, pesquise e acesse o serviço **RDS**.
2.  No painel do serviço, clique em **Databases** (Bancos de dados) e, em seguida, no botão **Create database** (Criar banco de dados).

<img src="https://github.com/user-attachments/assets/59d45327-cd83-4f9e-b05f-5cf1c5113f66" alt="Acessando o serviço RDS">

---

### 🔹 Passo 2: Configuração do Motor e Modelo

1.  **Choose a database creation method**: Selecione **Standard create** (Criação padrão).
2.  **Engine options**: Escolha **MySQL**.
3.  **Templates**: Selecione **Free tier** (Nível gratuito) para evitar custos durante o desenvolvimento. Isso ajustará automaticamente algumas opções para se enquadrarem na camada gratuita.

<img src="https://github.com/user-attachments/assets/6fe01842-e527-4a86-be7d-b6ea8a8d88b9" alt="Configuração do Motor e Template">
<img src="https://github.com/user-attachments/assets/4a1aeb76-e59e-4283-8e83-b4981c4de91e" alt="Seleção do Free Tier">

---

### 🔹 Passo 3: Configurações da Instância (Settings)

1.  **DB instance identifier**: Dê um nome único para a instância. Ex: `wordpress-db`.
2.  **Master username**: Defina o nome do usuário administrador. Ex: `admin`.
3.  **Master password**: Defina uma senha segura para o usuário master e confirme-a. Anote essa senha, pois você precisará dela no script `user_data`.

<img src="https://github.com/user-attachments/assets/3e512c81-8fa0-404b-acda-b95d4d93c4ea" alt="Configurações de Identificação e Credenciais">

---

### 🔹 Passo 4: Configurações de Armazenamento

1.  **DB instance class**: Mantenha a instância `db.t3.micro` (ou outra da camada gratuita).
2.  **Storage**: Mantenha as configurações padrão do Free Tier, que geralmente são `gp3` com **20 GB** de armazenamento.
3.  **Storage autoscaling**: Habilite o `Enable storage autoscaling` para permitir que o armazenamento cresça automaticamente se necessário, evitando que o site saia do ar por falta de espaço.

<img src="https://github.com/user-attachments/assets/f9e6d496-5e8a-48d8-bd84-6b341987bb95" alt="Configurações de Instância e Armazenamento">

---

### 🔹 Passo 5: Conectividade

1.  **Virtual private cloud (VPC)**: Selecione a **VPC** que você criou para o projeto.
2.  **Public access**: Garanta que a opção esteja marcada como **No**. Isso é crucial para a segurança, pois impede que o banco de dados seja acessado diretamente da internet.
3.  **VPC security group**: Selecione **Choose existing** e escolha o Security Group **`rds-sg`** que criamos anteriormente.
4.  **Availability Zone**: Pode manter como **No preference** (Sem preferência).

<img src="https://github.com/user-attachments/assets/8e293146-e330-4b50-bf2d-c47a3bf46b0e" alt="Configuração de Conectividade">
<img src="https://github.com/user-attachments/assets/a72f4a16-af81-49f4-99cc-160f84b3b539" alt="Configuração de Security Group">

---

### 🔹 Passo 6: Configurações Adicionais e Criação

1.  Expanda a seção **Additional configuration**.
2.  **Initial database name**: Dê um nome ao primeiro banco de dados que será criado. Ex: `wordpress`. Este é o nome que será usado no `docker-compose.yaml`.
3.  **DB parameter group**: Mantenha o `default`.
4.  **Automated backups**: Desabilite a opção **Enable automated backups** para economizar custos neste projeto.
5.  Revise as configurações e clique em **Create database**.

<img src="https://github.com/user-attachments/assets/931a00c1-347e-46e5-9467-1380ffc96097" alt="Criação do Banco de Dados">

---

### 📌 Resultado Esperado

Após alguns minutos, sua instância de banco de dados estará disponível. O mais importante é obter o **Endpoint** dela.

> ⚠️ **Ação Crítica:**
> Com a instância no estado "Available", clique nela e, na aba **Connectivity & security**, copie o valor do **Endpoint**. Você precisará colar esse endereço no seu script `user_data` para que o WordPress possa se conectar ao banco de dados.