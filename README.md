# Oficina Modelo

Este projeto foi desenvolvido para a gestão de uma oficina mecânica, abrangendo a modelagem de banco de dados e o gerenciamento de informações essenciais para o funcionamento da oficina. O objetivo é centralizar dados sobre clientes, veículos, serviços, peças, fornecedores e pagamentos, proporcionando uma maneira eficiente de gerenciar todas as operações de uma oficina mecânica.

## Estrutura do Banco de Dados

O modelo de dados foi estruturado com diversas tabelas inter-relacionadas, incluindo informações sobre clientes, veículos, peças, serviços prestados, fornecedores, ordens de serviço e pagamentos. O banco de dados foi projetado para armazenar e consultar informações de forma rápida e eficiente.

### Tabelas do Banco de Dados:
- **Cliente:** Contém os dados dos clientes, como nome, CPF, telefone e endereço.
- **Veículo:** Armazena informações dos veículos, como marca, modelo, ano e placa.
- **Peça:** Detalha as peças utilizadas nos serviços, incluindo código, nome e preço.
- **Serviço:** Registra os serviços realizados na oficina, com informações como tipo, descrição e valor.
- **Fornecedor:** Armazena dados sobre os fornecedores de peças e serviços terceirizados.
- **Ordem de Serviço:** Relaciona os serviços solicitados pelos clientes, incluindo o veículo, peças e serviços específicos.
- **Pagamento:** Registra as informações sobre os pagamentos feitos pelos clientes, incluindo data e valor.

### Diagrama Entidade-Relacionamento (ER)

O diagrama ER do projeto pode ser visualizado na imagem abaixo:

![Diagrama ER](Oficina_completa%20ER.png)

### Scripts SQL

O banco de dados foi estruturado com o script SQL `oficina_modelo.sql`, que pode ser utilizado para criar as tabelas e suas relações no banco de dados. Basta executar o script no seu sistema de gerenciamento de banco de dados preferido para criar a estrutura completa.

## Como Executar o Projeto

1. Clone o repositório para o seu ambiente local:
   ```bash
   git clone https://github.com/hellenohm/oficina_modelo.git
Importe o arquivo oficina_modelo.sql no seu banco de dados.

Utilize as tabelas para inserir, consultar e gerenciar dados relacionados à oficina.

Contribuições
Contribuições são bem-vindas! Caso queira sugerir melhorias ou correções, fique à vontade para abrir uma issue ou criar um pull request.

Licença
Este projeto é de código aberto e distribuído sob a licença MIT.
