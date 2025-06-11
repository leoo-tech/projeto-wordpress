# 🔐 Etapa 2: Criação dos Security Groups

Nesta etapa, vamos criar as "firewalls" do nosso ambiente. [cite_start]Serão 4 Security Groups (SGs), cada um responsável por isolar e proteger um componente específico da arquitetura, controlando todo o tráfego de entrada (Inbound) e saída (Outbound). 

> [cite_start]* 🖥️ **`ec2-sg`**: Para as Instâncias EC2 
> * 🌐 **`lb-sg`**: Para o Load Balancer 
> [cite_start]* 📁 **`efs-sg`**: Para o Elastic File System (EFS) 
> [cite_start]* 🗄️ **`rds-sg`**: Para o Banco de Dados (RDS) 

---

### 🔹 Passo 1: Acessar o Painel de Security Groups

1.  No Console da AWS, pesquise por **Security Groups**. 
2.  Na página do serviço, clique em **Create Security Group** (Criar Security Group) no canto superior direito. 

<img src="https://github.com/user-attachments/assets/d2eb7d39-6a47-4e12-8d17-529c4ed31a5f" alt="Acessando Security Groups">
<img src="https://github.com/user-attachments/assets/bb2b40e6-b916-45c4-91b0-0af7a17a321f" alt="Botão Criar Security Group">

---

### 🔹 Passo 2: Configurar cada Security Group

Para cada um dos 4 SGs, você irá preencher as informações básicas (Nome, Descrição, VPC) e, em seguida, configurar suas regras de Inbound e Outbound.

> 📝 **Observação**: Os nomes (`ec2-sg`, `lb-sg`, etc.) são sugestões para manter a consistência. Sinta-se à vontade para usar os nomes que preferir. 

---

### 🔐 SG 1: Load Balancer (`lb-sg`)

Este SG é a porta de entrada da internet para a nossa aplicação.

* [cite_start]**Nome**: `lb-sg` 
* [cite_start]**Descrição**: `Security Group para o Load Balancer` 
* [cite_start]**VPC**: Selecione a VPC criada na etapa anterior. 

<img src="https://github.com/user-attachments/assets/d2f92fed-7fb0-49ff-99d7-1bb6662ba0d9" alt="Criando o SG do LB">

#### Regras do `lb-sg`

| Regras de Entrada (Inbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Origem** | **Motivo** |
| HTTP | 80 | `0.0.0.0/0` | [cite_start]Receber tráfego da internet.  |

<img src="https://github.com/user-attachments/assets/1e785b39-9f83-43e1-8880-eafd946d33a6" alt="Regras de Entrada do LB">

| Regras de Saída (Outbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Destino** | **Motivo** |
| HTTP | 80 | `ec2-sg` | [cite_start]Encaminhar requisições para as instâncias EC2.  |

<img src="https://github.com/user-attachments/assets/8413427b-761b-49b1-a656-d9952b74c15e" alt="Regras de Saída do LB">

---

### 🔐 SG 2: Instâncias EC2 (`ec2-sg`)

[cite_start]Este SG protege as instâncias que rodam o WordPress. 

* [cite_start]**Nome**: `ec2-sg` 
* [cite_start]**Descrição**: `Security Group para as instancias EC2` 
* [cite_start]**VPC**: Selecione a VPC criada na etapa anterior. 

<img src="https://github.com/user-attachments/assets/7c57d5d2-b3be-42e6-bb31-25ebd7f72448" alt="Criando o SG da EC2">

#### Regras do `ec2-sg`

| Regras de Entrada (Inbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Origem** | **Motivo** |
| HTTP | 80 | `lb-sg` | [cite_start]Receber tráfego vindo exclusivamente do Load Balancer.  |
| SSH | 22 | `Seu IP` | [cite_start]Permitir seu acesso para manutenção (mais seguro).  |
| NFS | 2049 | `efs-sg` | [cite_start]Permitir a montagem do volume EFS.  |

<img src="https://github.com/user-attachments/assets/56d0f2df-8e30-46f5-85f3-2727cfcc19eb" alt="Regras de Entrada da EC2">

| Regras de Saída (Outbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Destino** | **Motivo** |
| All traffic | All | `0.0.0.0/0` | [cite_start]Acesso à internet via NAT Gateway para instalar pacotes e se conectar a outros serviços.  |

<img src="https://github.com/user-attachments/assets/ec682e0a-4a18-4e58-8021-e512b495208b" alt="Regras de Saída da EC2">

---

### 🔐 SG 3: EFS (`efs-sg`)

[cite_start]Este SG protege o nosso sistema de arquivos compartilhado. 

* [cite_start]**Nome**: `efs-sg` 
* [cite_start]**Descrição**: `Security Group para o EFS` 
* [cite_start]**VPC**: Selecione a VPC criada na etapa anterior. 

<img src="https://github.com/user-attachments/assets/34215fad-eb42-479a-aba1-63f0537cd17d" alt="Criando o SG do EFS">

#### Regras do `efs-sg`

| Regras de Entrada (Inbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Origem** | **Motivo** |
| NFS | 2049 | `ec2-sg` | [cite_start]Permitir que as instâncias EC2 montem o volume.  |

<img src="https://github.com/user-attachments/assets/108fd751-7432-489f-b0be-b40ddcf0e277" alt="Regras de Entrada do EFS">

| Regras de Saída (Outbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Destino** | **Motivo** |
| NFS | 2049 | `ec2-sg` | [cite_start]Permitir a comunicação de volta para a EC2.  |

<img src="https://github.com/user-attachments/assets/648b01ab-3a08-447f-a97a-c9462f5a65f6" alt="Regras de Saída do EFS">

---

### 🔐 SG 4: RDS (`rds-sg`)

[cite_start]Este SG protege nosso banco de dados. 

* [cite_start]**Nome**: `rds-sg` 
* [cite_start]**Descrição**: `Security Group para o RDS` 
* [cite_start]**VPC**: Selecione a VPC criada na etapa anterior. 

<img src="https://github.com/user-attachments/assets/9cacb32f-45ec-4b02-bbcc-647b47355a6a" alt="Criando o SG do RDS">

#### Regras do `rds-sg`

| Regras de Entrada (Inbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Origem** | **Motivo** |
| MySQL/Aurora | 3306 | `ec2-sg` | [cite_start]Permitir que a aplicação WordPress acesse o banco de dados.  |

<img src="https://github.com/user-attachments/assets/690e4df3-dfda-45fc-b2c2-c64df88b366a" alt="Regras de Entrada do RDS">

| Regras de Saída (Outbound) | | | |
| :--- | :--- | :--- | :--- |
| **Tipo** | **Porta** | **Destino** | **Motivo** |
| MySQL/Aurora | 3306 | `ec2-sg` | [cite_start]Permitir que o banco responda às requisições da EC2.  |

<img src="https://github.com/user-attachments/assets/4a16aada-1c36-4536-82a9-e343d3632363" alt="Regras de Saída do RDS">

---

### 📌 Resultado Esperado

Ao final desta etapa, você terá quatro Security Groups criados e configurados, cada um com regras específicas que garantem a comunicação segura e controlada entre os componentes da sua arquitetura, seguindo o princípio de menor privilégio.

<img src="https://github.com/user-attachments/assets/08626e35-f284-4895-a75e-8017fe75ebd5" alt="Visualização Final dos SGs">