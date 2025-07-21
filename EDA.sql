-- EDA - Analise de dados Exploratoria

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- Explorando e vendo o que tem aqui
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Quais faliram
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- total que demitiram
SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT sum(total_laid_off)
FROM layoffs_staging2;

-- vendo as datas
SELECT company, min(`date`), max(`date`)
FROM layoffs_staging2
GROUP BY 1;

-- Quais industrias tão caindo
SELECT Industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;

-- Quais paises tão piores

SELECT Country, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;

-- Por ano

SELECT year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY 1
ORDER BY 1 DESC;

-- Estagio

SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;

-- Por localização

SELECT location, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;


-- Rolling total de demissão por mes e ano

SELECT SUBSTRING(`date`, 1, 7) As `YEAR-MONTH`, sum(total_laid_off)
FROM layoffs_staging2
where `YEAR-MONTH` is not null
group by `YEAR-MONTH`
order by 1 asc;

WITH ROLLING_TOTAL AS
(
SELECT SUBSTRING(`date`, 1, 7) As `YEAR-MONTH`, sum(total_laid_off) AS total_off
FROM layoffs_staging2
where SUBSTRING(`date`, 1, 7) is not null
group by `YEAR-MONTH`
order by 1 asc
)
SELECT `YEAR-MONTH`, total_off, Sum(total_off) OVER(ORDER BY `YEAR-MONTH`) AS rolling_total
from ROLLING_TOTAL
;

-- empresas por ano demitiram

SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY COMPANY;


SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`);

WITH Company_year(company, years, total_laid_off) as 
(
SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, dense_rank() over(partition by years order by total_laid_off DESC) AS ranks
FROM Company_year
WHERE years is not null
ORDER BY ranks;

agora readme desse
