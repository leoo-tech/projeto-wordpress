# 📈 Etapa 7: Configurando o Auto Scaling Group

Chegamos à etapa final da configuração da nossa infraestrutura. O Auto Scaling Group (ASG) é o serviço que automatiza a criação e o gerenciamento das nossas instâncias EC2. Ele garantirá que sempre tenhamos o número desejado de instâncias rodando e as substituirá automaticamente em caso de falha.

> **🎯 Objetivo do Auto Scaling Group:**
> * Unir todos os componentes: VPC, Sub-redes, Launch Template e Load Balancer.
> * Garantir a alta disponibilidade, mantendo um número mínimo de instâncias sempre ativas.
> * Prover escalabilidade, permitindo que o número de instâncias cresça para atender a uma demanda maior.
> * Automatizar a recuperação de falhas, substituindo instâncias não saudáveis.

---

### 🔹 Passo 1: Iniciar a Criação do Auto Scaling Group

1.  No Console da AWS, navegue até **EC2 > Auto Scaling Groups** (no menu lateral).
2.  Clique em **Create Auto Scaling group**.

---

### 🔹 Passo 2: Escolher o Launch Template

1.  **Auto Scaling group name**: Dê um nome ao seu grupo. Ex: `wordpress-asg`.
2.  **Launch template**: Selecione o `wordpress-template` que criamos na etapa anterior. Verifique se a versão está como **Latest** (Mais recente).
3.  Clique em **Next**.

<img src="/imgs/scalingNome.png" alt="Selecionando o Launch Template">

---

### 🔹 Passo 3: Configurar a Rede

1.  **VPC**: Selecione a VPC do nosso projeto.
2.  **Availability Zones and subnets**: Selecione as **duas sub-redes privadas** que criamos. É crucial usar as sub-redes privadas para manter nossas instâncias seguras e não expostas diretamente à internet. O ASG irá distribuir as instâncias entre essas duas sub-redes para garantir a alta disponibilidade.
3.  Clique em **Next**.

<img src="/imgs/scalingRede.png" alt="Configurando a Rede do ASG">

---

### 🔹 Passo 4: Anexar o Load Balancer

1.  Selecione **Attach to an existing load balancer**.
2.  Escolha a opção **Choose from your load balancer target groups**.
3.  Selecione o Target Group que criamos anteriormente: `wordpress-tg`. O ASG agora saberá onde registrar as novas instâncias.
4.  Clique em **Next**.

<img src="/imgs/scalingLB.png" alt="Anexando o Load Balancer">

---

### 🔹 Passo 5: Definir o Tamanho do Grupo e Políticas

1.  **Desired capacity (Capacidade desejada)**: Defina como **2**. O ASG iniciará com duas instâncias.
2.  **Minimum capacity (Capacidade mínima)**: Defina como **2**. Isso garante que sempre teremos no mínimo duas instâncias rodando.
3.  **Maximum capacity (Capacidade máxima)**: Defina como **4**. Isso permite que o grupo cresça até quatro instâncias se implementarmos políticas de scaling no futuro.
4.  **Scaling policies**: Mantenha como **None** (Nenhuma) por enquanto.
5.  Clique em **Next** até chegar à última tela de revisão.

<img src="/imgs/scalingQTN.png" alt="Definindo o Tamanho do Grupo">

---

### 🔹 Passo 6: Revisar e Criar

1.  Revise todas as configurações na última página.
2.  Clique em **Create Auto Scaling group**.

<img src="/imgs/scalingFinal.png" alt="Criação Final do ASG">

---

### 📌 Resultado Esperado

Ao final desta etapa, o Auto Scaling Group começará a trabalhar imediatamente, provisionando o número desejado de instâncias (duas, neste caso) nas sub-redes privadas.

Você pode ir ao painel de **Instâncias EC2** para ver as novas máquinas sendo criadas. Após alguns minutos (enquanto o script `user-data` é executado), elas serão registradas no Target Group do Load Balancer e o status delas mudará para **`healthy`**. Seu ambiente WordPress estará completo, funcional, escalável e com alta disponibilidade!