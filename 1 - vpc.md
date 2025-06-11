# 🌐 Etapa 1: Criação da VPC Personalizada

Nesta etapa, vamos construir a fundação de rede para o nosso projeto. A VPC (Virtual Private Cloud) criará um ambiente seguro e isolado para a aplicação WordPress, garantindo que os componentes se comuniquem de forma privada e segura.

> **🎯 Objetivo da VPC:**
> [cite_start]* Criar um ambiente controlado para a aplicação WordPress.
> [cite_start]* Conectar de forma privada a EC2, o RDS e o EFS.
> * Garantir que o tráfego de internet passe apenas pelo Load Balancer, evitando IPs públicos nas instâncias.
> [cite_start]* Organizar os componentes em sub-redes apropriadas (públicas e privadas).

---

### 🔹 Passo 1: Acessar o Assistente de Criação de VPC

1.  No Console da AWS, na barra de busca, pesquise e acesse o serviço **VPC**.
2.  [cite_start]No painel do serviço, clique no botão **Create VPC** (Criar VPC).

    <img src="https://github.com/user-attachments/assets/a53e1b82-c09b-4fe5-b1c8-924baf2a5f60" alt="Acessando o serviço VPC">
    <img src="https://github.com/user-attachments/assets/61462f2f-99c2-4459-b558-3686c3ab5993" alt="Botão Criar VPC">

---

### 🔹 Passo 2: Configurar a VPC e seus Recursos

Na tela de criação, vamos usar o assistente **"VPC and more"** para configurar todos os componentes de rede de uma só vez.

1.  **Recursos para criar**: Mantenha a opção **VPC and more** selecionada.
2.  **Name tag auto-generation**: Dê um nome base para seus recursos. Ex: `wordpress-project`.
3.  [cite_start]**IPv4 CIDR block**: Deixe o padrão `10.0.0.0/16`.
4.  [cite_start]**Number of Availability Zones (AZs)**: Selecione **2**.
5.  [cite_start]**Number of public subnets**: Defina como **2**.
6.  [cite_start]**Number of private subnets**: Defina como **2**.
7.  [cite_start]**NAT Gateways**: Selecione **1 per AZ** (um por Zona de Disponibilidade). Isso é essencial para que as instâncias privadas possam acessar a internet para instalar pacotes.
8.  [cite_start]**VPC Endpoints**: Mantenha como **None** (Nenhum).

<br>

<img src="https://github.com/user-attachments/assets/39ce202a-8176-4b62-94a4-133b8a3616ef" alt="Configuração do Bloco CIDR">
<img src="https://github.com/user-attachments/assets/68343ab7-5dc3-4701-b1b8-fb82e91f2a28" alt="Configuração de Sub-redes e Gateways">

---

### 🔹 Passo 3: Criar e Verificar

1.  Após preencher as configurações, revise o diagrama de arquitetura no final da página para garantir que tudo está correto.
2.  [cite_start]Clique no botão **Create VPC**.

    <img src="https://github.com/user-attachments/assets/b533d40d-1358-4991-88d5-a1379dd26523" alt="VPC Criada com Sucesso">

---

### 📌 Resultado Esperado

[cite_start]Ao final desta etapa, você terá uma infraestrutura de rede robusta e pronta para a aplicação:
* [cite_start]Uma VPC com 2 Zonas de Disponibilidade distintas.
* [cite_start]2 sub-redes públicas (para recursos como o Load Balancer).
* [cite_start]2 sub-redes privadas (para recursos como as instâncias EC2 e o RDS).
* [cite_start]2 NAT Gateways, garantindo acesso à internet para as sub-redes privadas.