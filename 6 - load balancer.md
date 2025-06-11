# ⚖️ Etapa 6: Criação do Application Load Balancer

O Load Balancer (ALB) atua como o "controlador de tráfego" do nosso site. Ele recebe todas as requisições da internet e as distribui de forma inteligente entre as instâncias EC2 ativas, garantindo alta disponibilidade e escalabilidade.

> **🎯 Objetivo do Load Balancer:**
> * Ser o único ponto de entrada público para a aplicação.
> * Distribuir o tráfego HTTP entre múltiplas instâncias em diferentes Zonas de Disponibilidade.
> * Realizar verificações de integridade (Health Checks) para enviar tráfego apenas para instâncias saudáveis.

---

O processo de criação é dividido em duas partes:
1.  **Criação do Target Group (Grupo de Destino)**: Define *quais* instâncias receberão o tráfego e *como* verificar se elas estão saudáveis.
2.  **Criação do Load Balancer**: Define *de onde* o tráfego vem e *para qual* Target Group ele deve ser enviado.

### Parte 1: Criação do Target Group

1.  No console da AWS, navegue até **EC2 > Target Groups** (no menu lateral).
2.  Clique em **Create target group**.

#### Configurações do Target Group:

1.  **Choose a target type**: Selecione **Instances**.
2.  **Target group name**: Dê um nome. Ex: `wordpress-tg`.
3.  **Protocol / Port**: Use **HTTP** e a porta **80**.
4.  **VPC**: Selecione a VPC criada para o projeto.
5.  **Health checks (Verificação de Integridade)**:
    * **Health check protocol**: Mantenha **HTTP**.
    * **Health check path**: Use `/`. Se você instalou um plugin de health check, pode usar `/health`.
    * Expanda **Advanced health check settings** e em **Success codes**, defina como `200,302`. Isso é importante para que o WordPress passe na verificação, mesmo ao redirecionar para a página de setup.

    <img src="/imgs/destinonome.png" alt="Configuração do Nome do Target Group">
    <img src="/imgs/destinoIntegro.png" alt="Configuração do Health Check">

6.  Clique em **Next**. Na tela "Register targets", **não adicione nenhuma instância manualmente**. O Auto Scaling Group fará isso de forma automática. Apenas clique em **Create target group**.

---

### Parte 2: Criação do Load Balancer

1.  Agora, no menu lateral, navegue para **EC2 > Load Balancers**.
2.  Clique em **Create Load Balancer**.
3.  Selecione **Application Load Balancer** e clique em **Create**.

#### Configurações do Load Balancer:

1.  **Load Balancer name**: Dê um nome. Ex: `wordpress-lb`.
2.  **Scheme**: Mantenha **Internet-facing** (De frente para a internet).
3.  **Network mapping**:
    * **VPC**: Selecione a sua VPC.
    * **Mappings**: Selecione as duas Zonas de Disponibilidade (`us-east-1a`, `us-east-1b`) e, para cada uma, escolha a **sub-rede pública** correspondente.
4.  **Security groups**: Remova o SG `default` e adicione o **`lb-sg`** que criamos.
5.  **Listeners and routing**:
    * A regra padrão para a porta **HTTP:80** deve encaminhar o tráfego (Forward to) para o Target Group que acabamos de criar (`wordpress-tg`).

    <img src="/imgs/LBnome.png" alt="Configuração do Nome do LB">
    <img src="/imgs/LBrede.png" alt="Configuração de Rede do LB">
    <img src="/imgs/destino.png" alt="Configuração do Listener">

6.  Revise o sumário e clique em **Create Load Balancer**.

<img src="/imgs/LBfinal.png" alt="Criação Final do LB">

---

### 📌 Resultado Esperado

Ao final desta etapa, você terá um Application Load Balancer pronto para receber tráfego da internet e um Target Group configurado para verificar a saúde das futuras instâncias.

> 📎 **Ação Importante:**
> Após a criação, anote o **DNS name** do seu Load Balancer. Será através deste endereço que você acessará seu site WordPress.