WCars

App vitrine para loja de carros com painel administrativo


Requisitos
- Flutter 3

Instalação
 - Flutter pub get
 - flutter pub run build_runner watch --delete-conflicting-outputs

 Credenciais de primeiro acesso
 Usuario: wsilveira
 Senha:  123456

 - Observação
 Segue link da collection com as possiveis requisições.
 https://elements.getpostman.com/redirect?entityId=27479389-3525a851-e542-41a0-8f47-d49cb272fefd&entityType=collection
 Cadastro de adm
 Listagem, Alteração, Cadastro e Exclusão de carros

Observação acessar o arquivo lib/data/remote/custom_dio.dart e alterar o ip que aponta para o backend local.
EX:. _dio.options.baseUrl = "http://192.168.0.8:3000/";

