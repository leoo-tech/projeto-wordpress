# 📁 Etapa 3: Criação do Elastic File System (EFS)

Agora vamos criar o nosso "HD de rede". O Amazon EFS é um sistema de arquivos compartilhado que permitirá que todas as nossas instâncias WordPress acessem e salvem arquivos (como imagens e plugins) no mesmo lugar, garantindo a persistência dos dados.

> **🎯 Objetivo do EFS:**
>  * O Amazon EFS é um sistema de arquivos escalável, elástico e totalmente gerenciado. 
>  * Ele permite compartilhar dados entre várias instâncias EC2 simultaneamente, como se fosse um pendrive em rede (NFS). 
> * Diferente do EBS (que é ligado a uma única instância), o EFS pode ser montado em várias EC2s ao mesmo tempo, o que é ideal para o nosso ambiente WordPress com múltiplas instâncias. 

---

### 🔹 Passo 1: Acessar o Painel do EFS

1.  No Console da AWS, pesquise por **EFS** e acesse o serviço.
2.   No painel do EFS, clique em **File systems** no menu lateral e, em seguida, no botão **Create file system**. 

<img src="https://github.com/user-attachments/assets/b940c290-c511-436c-b4dd-752d60b7ac27" alt="Acessando o serviço EFS">
<img src="https://github.com/user-attachments/assets/9378a141-d816-46de-8404-29af0bc2e297" alt="Botão Criar File System">

---

### 🔹 Passo 2: Configurações Gerais

Nesta primeira tela, definiremos o nome, a rede e as configurações de armazenamento.

1.  **Name**: Dê um nome para seu sistema de arquivos.  Ex: `wordpress-efs`. 
2.   **VPC**: Selecione a VPC que criamos na primeira etapa. 
3.   **File system type**: Escolha **Regional**, para garantir alta disponibilidade entre as Zonas de Disponibilidade. 

<img src="https://github.com/user-attachments/assets/3ddbf688-da87-4f13-bfa6-556ec39bcff8" alt="Configurações Iniciais do EFS">

4.   **Automatic backups**: Desabilite a opção **Enable automatic backups** para este projeto, visando a economia de custos. 
5.   **Throughput mode**: Mantenha como **Bursting**, que é adequado para cargas de trabalho variáveis como um site WordPress. 
6.   **Performance mode**: Mantenha como **General Purpose**, o modo recomendado para a maioria dos casos de uso com baixa latência. 

<img src="https://github.com/user-attachments/assets/fa73b210-1bcd-40bd-b240-41e3c9c540d5" alt="Configurações de Backup e Tipo">
<img src="https://github.com/user-attachments/assets/0dece95f-21e1-46a9-b2f2-231cbf0f3572" alt="Configurações de Performance">

---

### 🔹 Passo 3: Configurar Acesso de Rede (Mount Targets)

Aqui vamos definir como nossas instâncias EC2 acessarão o EFS.

1.  Verifique se a **VPC** correta está selecionada.
2.  Para as Zonas de Disponibilidade (`us-east-1a` e `us-east-1b`), faça o seguinte:
    * **Subnet ID**: Selecione a **sub-rede privada** correspondente a cada Zona de Disponibilidade.
    *  **Security groups**: Remova o SG `default` e adicione o **`efs-sg`** que criamos na etapa anterior. 
3.  Clique em **Next** para avançar.

<img src="https://github.com/user-attachments/assets/c5b64129-b108-4df0-8791-454c8ce4172b" alt="Configurando os Mount Targets">

---

### 🔹 Passo 4: Revisar e Criar

1.  A próxima tela mostrará uma política de acesso. Não é necessário alterá-la.  Apenas clique em **Next**. 
2.  Revise todas as configurações e clique em **Create** para finalizar a criação do seu EFS.

<img src="https://github.com/user-attachments/assets/930b191a-60ca-4046-a95d-c58198ebeecb" alt="Revisão da Política de Acesso">

---

### 🔹 Passo 5: Anotar o File System ID

> ⚠️ **Importante!**
>  Após a criação, anote o **ID do File System** (ex: `fs-12345678`).   Você precisará dessa informação para colar no script de inicialização (`user_data`) da sua instância EC2, permitindo que ela monte o EFS corretamente. 

<img src="https://github.com/user-attachments/assets/85b26625-7d94-4311-94dc-8a55290dae86" alt="Anotando o ID do File System">

---

### 📌 Resultado Esperado

Ao final desta etapa, você terá um sistema de arquivos EFS criado, acessível a partir das sub-redes privadas da sua VPC e protegido pelo seu respectivo Security Group. Ele está pronto para armazenar de forma persistente os arquivos do seu site WordPress.