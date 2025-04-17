# My Vehicles 🚗🛵🚐

Um app flutter que salva informações básicas sobre os veículos favoritos do usuário.

> [!IMPORTANT]
> Para rodar o projeto é necessário ter o dart e flutter instalado em sua máquina.

## Stack utilizada:
- Dart
- Framework Flutter
- Pacote `http` para realizar requisições

## Como instalar:
- Clonar este repositório do diretório que deseja `git clone https://github.com/gustavoc0imbra/MyVehicles.git`
- Após clonar acessar a pasta do projeto `cd MyVehicles`
- E no terminal onde o projeto está aberto rodar o comando `flutter pub get` para baixar as dependências do projeto

## Como rodar:
- Através de algum terminal aberto no diretório do projeto rodar o comando `flutter run`
- Ele irá perguntar em qual dispositivo deseja rodar, selecione o de sua preferência. Recomendado selecionar a opção do Google Chrome para evitar bugs

## Funcionamento do projeto
### Assim que iniciar o projeto a primeira tela que conterá o os campos necessários para salvar a informação do veículo:
> [!NOTE]
> Todos os campos são obrigatórios:
- Marca
- Tipo do veículo (Moto, Carro, SUV, Van)
- Modelo do veículo
- Nome
  
![image](https://github.com/user-attachments/assets/4832be24-80f9-41b3-b1b7-0655f3abd39b)

### Caso o usuário não informe algum desses campos durante o envio, o app avisará com uma janela para preencher todos os campos:

![image](https://github.com/user-attachments/assets/dbbc1855-7d67-4e24-81b5-1731a82ec2d4)

### Ao final de preencher os dados corretamente será enviado para um serviço externo e irá exibir uma janela para avisar que foi salvo com sucesso e irá atualizar a lista de veículos com o novo cadastrado:
  
![image](https://github.com/user-attachments/assets/0512ec8f-3d39-4c93-bbff-34f376eda964)

> [!NOTE]
> - Ao lado do botão de enviar há o botão de resetar que ao clicar limpa os campos para facilitar para o usuário preencher os campos se assim desejar.  
> - Logo abaixo do formulário há a lista que exibe as informações dos veículos, a marca, tipo, modelo e nome.
