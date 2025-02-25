# Lista de Tarefas

Este é um aplicativo de lista de tarefas desenvolvido em Flutter. O aplicativo permite que os usuários adicionem, visualizem e excluam tarefas.

## Funcionalidades

- Adicionar uma nova tarefa
- Exibir a lista de tarefas
- Excluir uma tarefa individualmente
- Limpar todas as tarefas
- Contagem de tarefas pendentes

## Estrutura do Projeto

- `models/tasks.dart`: Define o modelo de dados para as tarefas.
- `repositories/task_repository.dart`: Gerencia a persistência dos dados das tarefas.
- `widgets/todo_list_item.dart`: Widget que representa um item da lista de tarefas.
- `pages/todo_list_page.dart`: Página principal que exibe a lista de tarefas e permite a interação do usuário.

## Como Executar

1. Certifique-se de ter o Flutter instalado em sua máquina. Para mais informações, consulte a [documentação do Flutter](https://flutter.dev/docs/get-started/install).

2. Clone este repositório:

   ```sh
   git clone <URL_DO_REPOSITORIO>
3. Navegue até o diretório do projeto:
   cd lista_de_tarefas
4. Instale as dependências:
   flutter pub get
5. Execute o aplicativo:
   flutter run
