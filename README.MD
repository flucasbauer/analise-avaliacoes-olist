
### **(Projeto em andamento)**

# Análise das avaliações dos clientes da loja de marketplace Olist

## 1. Contexto

Atualmente, as avaliações dos clientes representam um dos principais sinais de qualidade, credibilidade e reputação no mercado. Avaliações negativas tendem a influenciar diretamente a decisão de compra, levando o consumidor a desistir mesmo quando o produto atende às suas necessidades, enquanto avaliações positivas exercem o efeito oposto. Pela ótica das empresas, manter elevados níveis de satisfação reflete em fidelização, diferenciação e potencial de crescimento de receita, contribuindo para a maximização do lucro. Contudo, a análise de avaliações de clientes envolve dados majoritariamente categóricos e textuais, sendo desafios metodológicos onde, técnicas estatísticas podem oferecer alternativas que possibilitam a sua interpretação.

## 2. Objetivos

- Descobrir os principais fatores para as avaliações negativas dos clientes;
- Recomendar ações com potencial de maximizar a satisfação dos clientes e consequentemente sua avaliação.

## 3. Metódos

### 3.1. Modelo de regressão logística

O método quantitativo utilizado para embasar a pesquisa foi o modelo de regressão logística, também conhecido como modelo logit. Esse tipo de abordagem é indicado quando o objeto de estudo possui natureza qualitativa, como ocorre no caso das avaliações dos clientes. Situações em que a resposta de interesse é binária, por exemplo, identificar se a quantidade de fotos disponíveis de um produto aumenta ou reduz a probabilidade de um pedido ser avaliado negativamente, justificam o uso desse modelo. Nesse contexto, a variável resposta assume valores categóricos binários (1 para ocorrência do evento e 0 para não ocorrência), possibilitando estimar a probabilidade de um determinado resultado. A especificação do modelo pode ser representada pela seguinte equação:

### **(Projeto em andamento)**

### Atalhos para acesso aos arquivos do projeto
[Clique aqui](notebook/modelo.ipynb) para acessar ao notebook do modelo de regressão logística.   
[Clique aqui](querys/analise-1/query_nps.sql) para acessar a query com o cálculo do indicador NPS.     
[Clique aqui](querys/analise-1/query_db_logit.sql) para acessar a query com a estruturação da base de dados elaborada para o modelo logit.