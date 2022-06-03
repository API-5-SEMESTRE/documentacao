<h2 align="center"><img src="https://raw.githubusercontent.com/github/explore/3002c1497202fcd179aa4c64194ea859dfd49820/topics/devops/devops.png"></h2>


#### CI/CD do grupo TheVelopers

##### Versionamento
- Foi utilizado o GitHub como ferramenta de versionamento
- Dividimos o projeto em 4 branches
  - main: a branch de produção
  - hotfix: a branch destinada a correções de emergência, push somente para main e pull somente para a main, deve rodar todos os testes para manter a qualidade
  - dev: a branch para desenvolvimento, push para main, deve rodar todos os testes para manter a qualidade, também utilizamos a dev para um ambiente de testes, após os testes unitários e de integração pushamos ela para a Heroku
  - feature: a branch para desenvolvimento de novas features e bugfixs planejados, push para dev e pull da dev (é aconselhável sempre manter a feature atualizada para diminuir futuros conflitos na hora do merge com a dev), deve rodar todos os testes para manter a qualidade

##### Workflow 
- Utilizamos a ferramenta <a href="https://docs.github.com/pt/actions">Actions</a> do GitHub para o CI/CD (Continuous Integration e Continuous Delivery)

<details>
<summary>Gitflow para a branch main</summary>

```yaml

name: CI Main

on:
    push:
        branches: [ main ]

jobs:
  clean_build_deploy:
  
    runs-on: ubuntu-latest

    # Setando o ambiente
    environment:
      name: main

    steps:
      - name: Step 1 - checkout
        uses: actions/checkout@v2

      - name: Step 2 - set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: 11
      
      - name: Step 3 - cache local Maven repository
        uses: actions/cache@v3
        with:
            path: ~/.m2/repository
            key: ${{ runner.os }}-maven-${{ hashFiles('**/pom.xml') }}
            restore-keys: |
                        ${{ runner.os }}-maven-  
      
      - name: Step 4 - clean and build
        run: mvn -B -DskipTests clean package
    
      - name: Step 5 - build and push docker image
        uses: mr-smithers-excellent/docker-build-push@v4
        with:
            image: jef771/sas-app
            registry: docker.io
            username: ${{ secrets.DOCKER_USERNAME }}
            password: ${{ secrets.DOCKER_PASSWORD }}

```
</details>

<details>
<summary>Gitflow para a branch dev</summary>

```yaml

 name: CI Dev

on:
    push:
        branches: [ dev ]

jobs:

  build_and_test:
    runs-on: ubuntu-latest

    environment:
      name: dev

    steps:
      - name: Step 1 - checkout
        uses: actions/checkout@v2

      - name: Step 2 - set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: 11
      
      - name: Step 3- cache Maven packages
        uses: actions/cache@v1
        with:
          path: ~/.m2
          key: ${{ runner.os }}-m2-${{ hashFiles('**/pom.xml') }}
          restore-keys: ${{ runner.os }}-m2

      - name: Step 4 - unit/integration test
        run: mvn test

      - name: Step 5 - deploy heroku
        uses: akhileshns/heroku-deploy@v3.12.12
        with:
          heroku_api_key: ${{secrets.HEROKU_API_KEY}}
          heroku_app_name: "score-analysis-system-back"
          heroku_email: "score.analysis.sytem@gmail.com"

```
</details>

##### Unit Test
- Para os testes unitários utilizamos o próprio Maven e no próprio Gitflow (dev, feature e hotfix) rodamos os testes.

```yaml
- name: Step 4 - unit/integration test
        run: mvn test
```

##### Integration Test
- Para o teste de integração entre frontend e backend utilizamos o selenium e novamente o Maven para roda-lo no Gitflow (dev, feature e hotfix)

##### Migration
- Para migração do banco de dados, ou seja, atualizações de novas versões do banco de dados, utilizamos o flyway, ferramenta já consolidade no mercado de trabalho

```
    .
    ├── src                    
    │   └──── main
    │         └──── resources
    │               └──── db
    │                     └──── migration
    │                           └ V1_database_modification.sql
    │                 
    │                  
    └── ...
```

##### Documentação
- Para documentação dos end-points foi utilizado o swagger


<h2 align="center">🛠 Tecnologias</h2>

As seguintes ferramentas foram usadas na construção do DevOps:

<div style="display: flex;" align="center">
<a href="https://maven.apache.org/">
  <img src="https://img.shields.io/static/v1?label=GitHub&message=Versioning&color=black&style=for-the-badge&logo=Github"/>
</a>  
<a href="https://maven.apache.org/">
  <img src="https://img.shields.io/static/v1?label=Maven&message=Build&color=darkgray&style=for-the-badge&logo=ApacheMaven"/>
</a>
<a href="https://www.selenium.dev/">
  <img src="https://img.shields.io/static/v1?label=Selenium&message=Integration Test&color=F7DF1E&style=for-the-badge&logo=selenium"/>
</a>
<a href="https://flywaydb.org/">
<img src="https://img.shields.io/static/v1?label=Flyway&message=Migration&color=339933&style=for-the-badge&logo=Flyway"/>
</a>
<a href="https://www.docker.com/">
<img src="https://img.shields.io/static/v1?label=docker&message=Deploy&color=blue&style=for-the-badge&logo=docker"/>
</a>
<a href="https://www.heroku.com/">
  <img src="https://img.shields.io/static/v1?label=Heroku&message=hosting&color=430098&style=for-the-badge&logo=Heroku"/>
</a>
</div>
