# 🧠 Projeto SQL - EDA com Layoffs 2022

Este projeto tem como objetivo aplicar uma **análise exploratória de dados (EDA)** utilizando SQL, com base em um conjunto de dados público sobre demissões em massa no setor de tecnologia. Os dados são do Kaggle:

🔗 https://www.kaggle.com/datasets/swaptr/layoffs-2022

---

## 🛠️ Tecnologias utilizadas

- MySQL Workbench
- SQL (com funções como `GROUP BY`, `ROW_NUMBER`, `DENSE_RANK`, `WINDOW FUNCTIONS`)
- Dataset real (CSV)

---

## 📌 Etapas do Projeto

### 1️⃣ Limpeza de dados -- https://github.com/WilliamCutelo/Limpeza-de-dados
- Criação de staging table
- Remoção de duplicatas com `ROW_NUMBER()`
- Padronização de campos
- Tratamento de valores nulos
- Inserção em nova tabela limpa (`layoffs_staging2`)

### 2️⃣ Análise Exploratória (EDA)
- Máximos de demissões e porcentagem
- Empresas que demitiram 100%
- Total de demissões por empresa
- Demissões por país, setor, estágio e localidade
- Evolução por mês e por ano
- Ranking das empresas que mais demitiram por ano

---

## 📊 Exemplos de Consultas

**Maiores demissões e 100% de layoffs**
```sql
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

## ✅ Conclusão 

- Startups e empresas de tecnologia foram as mais afetadas.
- EUA lidera em número total de demissões.
- Muitos layoffs ocorreram em 2022 e 2023.
- Há relação entre estágio da empresa e cortes.
- Algumas empresas encerraram totalmente as atividades (100% layoffs).
