# ✅ Etapa Final: Validação e Teste do Ambiente

Chegamos ao momento da verdade! Com toda a infraestrutura configurada, é hora de realizar os testes finais para garantir que nosso site WordPress está funcional, persistente e com alta disponibilidade.

> **🎯 Objetivo da Validação:**
> * Confirmar que o Load Balancer está distribuindo o tráfego corretamente.
> * Realizar a instalação final do WordPress, testando a conexão com o banco de dados RDS.
> * Validar a persistência de arquivos, testando o armazenamento no EFS.
> * Publicar conteúdo para garantir que os dados do site são salvos no RDS.

---

### 🔹 Passo 1: Acessar o Site pelo Load Balancer

1.  [cite_start]No console da AWS, navegue até **EC2 > Load Balancers** e copie o **DNS name** do seu Load Balancer. 
2.  [cite_start]Cole o endereço DNS no seu navegador. 
3.  Você deverá ver a tela de seleção de idioma do WordPress. [cite_start]Selecione **Português do Brasil** e clique em **Continuar**. 

> ✅ **Checkpoint:** Se você vê esta tela, significa que o Load Balancer, o Target Group, o Auto Scaling Group e as instâncias EC2 com Docker estão todos funcionando em harmonia!

<img src="https://github.com/user-attachments/assets/e8f7558a-c957-412b-84f6-aa3f33e3596b" alt="Tela de Inicial do WordPress">

---

### 🔹 Passo 2: Instalação do WordPress

[cite_start]Na tela seguinte, preencha as informações para a configuração inicial do seu site. 

1.  [cite_start]**Título do site**: Escolha um título para o seu blog. 
2.  [cite_start]**Nome de usuário**: Crie seu usuário administrador. 
3.  [cite_start]**Senha**: Defina uma senha forte. 
4.  [cite_start]**Seu e-mail**: Insira um e-mail válido. 
5.  [cite_start]Clique em **Instalar WordPress**. 

> ✅ **Checkpoint:** Ao concluir a instalação, o WordPress salvou todas essas informações no banco de dados **RDS**, confirmando que a conexão está funcionando perfeitamente.

<img src="https://github.com/user-attachments/assets/0510ef52-e289-4f31-a81a-4beff1b77469" alt="Formulário de Instalação do WordPress">
<img src="https://github.com/user-attachments/assets/24d7ead5-1704-4430-b734-81b08d082fe5" alt="Tela de login">

---

### 🔹 Passo 3: Teste de Persistência (EFS e RDS)

Agora, vamos garantir que os arquivos e os posts são salvos de forma permanente.

1.  Faça login no painel administrativo do WordPress com o usuário e senha que você acabou de criar.
2.  No menu lateral, vá em **Posts > Adicionar Novo**.
3.  Crie um post de teste: adicione um título, um pouco de texto e, o mais importante, **faça o upload de uma imagem** para a biblioteca de mídia.
4.  [cite_start]Clique em **Publicar**. 

> ✅ **Checkpoint:**
> * Ao fazer o **upload da imagem**, ela foi salva no volume **EFS**.
> * Ao **publicar o post**, o texto e as informações foram salvos no banco de dados **RDS**.
> A persistência dos seus dados está confirmada!

<img src="https://github.com/user-attachments/assets/7e9f3db4-e8ae-4b55-a2c9-1f9550cce360" alt="Teste de Persistência">

---

### 📌 Resultado Final

**Parabéns!** Você concluiu com sucesso a implantação de um ambiente WordPress totalmente funcional, escalável e com alta disponibilidade na AWS.

Seu projeto agora conta com:
* **Alta Disponibilidade**: Com instâncias distribuídas em duas Zonas de Disponibilidade e gerenciadas por um Auto Scaling Group.
* **Escalabilidade**: Pronto para crescer e diminuir conforme a demanda.
* **Segurança**: Com a aplicação isolada em sub-redes privadas e o acesso controlado por Security Groups.
* **Dados Persistentes**: Com arquivos no EFS e banco de dados no RDS, garantindo que nenhuma informação seja perdida.