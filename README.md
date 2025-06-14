<table>
  <tr>
    <td>
    <td>
      <h1>Projeto: Deploy de WordPress com AWS</h1>
      <div align="center">
        <a href="https://skillicons.dev">
          <img src="https://skillicons.dev/icons?i=aws,docker,wordpress,mysql,linux" alt="My Skills">
        </a>
        <p align="center">
          <br>
          <br>      
          <img src="https://github.com/user-attachments/assets/79a2e995-a1be-4192-9ded-771004ef7417" width="200">
        </p>
      </div>
    </td>
  </tr>
</table>

## 📜 Descrição do Projeto

Este projeto tem como objetivo implantar uma aplicação WordPress em uma infraestrutura escalável e segura na AWS.   Para isso, são utilizados contêineres Docker, um banco de dados gerenciado com AWS RDS, armazenamento de arquivos compartilhado e persistente com AWS EFS, e a distribuição de tráfego é feita por um Load Balancer.

## 🗺️ Arquitetura da Solução
<img src="https://github.com/user-attachments/assets/6476bdfa-b2bb-484a-8030-e5a692b924a2" alt="Arquitetura do Projeto">

## 🧰 Tecnologias Utilizadas

| Tecnologia/Serviço | Função |
| :--- | :--- |
| **AWS EC2** | Servidores virtuais para executar os contêineres Docker. |
| **AWS RDS (MySQL)** | Banco de dados gerenciado, persistente e escalável para o WordPress.  |
| **AWS EFS** | Armazenamento de arquivos de rede, garantindo a persistência de plugins, temas e uploads.  |
| **AWS Load Balancer** | Distribuição de tráfego entre as instâncias e ponto de entrada da aplicação.  |
| **AWS Auto Scaling Group** | Garante a escalabilidade e a alta disponibilidade, criando ou encerrando instâncias conforme a necessidade. |
| **Docker** | Plataforma de contêineres para empacotar e executar a aplicação WordPress. |
| **Amazon Linux 2023** | Sistema operacional base para as instâncias EC2. |
| **Bash (`user_data`)**| Script de automação para configurar as instâncias na inicialização.  |

## ✅ Etapas do Deploy

A implantação completa está documentada passo a passo. A ordem sugerida é:

1.  **Configuração da Rede (VPC)**
2.  **Criação dos Grupos de Segurança (Security Groups)**
3.  **Criação do Sistema de Arquivos (EFS)** 
4.  **Criação do Banco de Dados (RDS)** 
5.  **Criação do Modelo de Execução (Launch Template com `user_data`)** 
6.  **Criação do Balanceador de Carga (Load Balancer)** 
7.  **Criação do Grupo de Auto Scaling (Auto Scaling Group)**
8.  **Teste e Validação Final** 

## 🧪 Teste e Validação

Para testar o ambiente, acesse o DNS do Load Balancer em um navegador.  A tela de instalação do WordPress (`/wp-admin/install.php`) deve ser exibida.  Após a configuração, valide se a instalação de plugins e o upload de imagens funcionam corretamente, confirmando a persistência no EFS e no RDS. 

## 🤔 Solução de Problemas Comuns (Troubleshooting)

Durante o deploy, alguns problemas comuns podem ocorrer:

* **Erro 502 Bad Gateway no Load Balancer**: Geralmente causado por uma falha na verificação de integridade (Health Check). Verifique se o Security Group da EC2 permite tráfego na porta 80 vindo do Security Group do Load Balancer.
* **Instâncias não ficam "Healthy"**: Pode ser um erro no script `user-data`. Conecte-se à instância e verifique os logs em `/var/log/cloud-init-output.log` e `/var/log/user-data.log` para encontrar erros.
* **WordPress pede credenciais de FTP**: Indica um problema de permissão de arquivos no EFS. Garanta que o dono do diretório do WordPress no EFS seja o usuário `www-data` (ID 33), usando `sudo chown -R 33:33 /caminho/do/wordpress` no `user_data`.

## 💸 Gerenciamento de Custos

Para pausar o ambiente e evitar custos desnecessários:
1.  Edite o **Auto Scaling Group** e defina a capacidade (Desired, Min, Max) como **0**.
2.  **Pare** a instância do **RDS** através do console da AWS.

**Atenção**: Para reiniciar, é preciso primeiro dar **Start** na instância RDS e depois ajustar a capacidade do Auto Scaling Group de volta para o valor desejado (ex: 2).
