# 1) EXIBIR O NOME DO FILME E SUA CATEGORIA

select
	f.title, c.name 
	from film f 
	inner join film_category fc 
		on fc.film_id = f.film_id
	inner join category c 
		on fc.category_id = c.category_id;
		
# 2) EXIBIR O NOME DO FILME E O ELENCO (NOMES DOS ATORES/ATRIZES)
	
select
	f.title as filme, group_concat(a.first_name, ' ', a.last_name  separator  ' | ' ) as elenco
	from film f 
	inner join film_actor fa 
		on fa.film_id = f.film_id 
	inner join actor a 
		on a.actor_id = fa.actor_id
	group by f.title;
	
	
# 3) EXIBIR O NOME DO ATOR/ATRIZ E OS NOMES DOS FILMES QUE O MESMO PARTICIPOU

select
	concat(a.first_name, ' ', a.last_name) as nome, group_concat(f.title separator ' | ') as filmes
	from film f 
	inner join film_actor fa 
		on fa.film_id = f.film_id 
	inner join actor a 
		on a.actor_id = fa.actor_id
	group by a.actor_id;

# 4) EXIBIR O NOME DO FILME E SUA QUANTIDADE NO INVENTÁRIO

select 
	f.title, count(*) quantidade_em_estoque
	from film f 
	inner join inventory i 
		on i.film_id = f.film_id
	group by f.film_id ;
	
	
# 5) EXIBIR A CATEGORIA E A QUANTIDADE DE FILMES POR CATEGORIA

select 
	c.name, count(*)
	from category c
	inner join film_category fc 
		on fc.category_id = c.category_id 
	inner join film f 
		on f.film_id = fc.film_id 
	group by c.name;

# 6) EXIBIR O FILME E A QUANTIDADE DE ATORES DO SEU ELENCO

select 
	f.title, count(*)
	from film f
	inner join film_actor fa 
		on fa.film_id = f.film_id 
	inner join actor a 
		on a.actor_id = fa.actor_id
	group by f.film_id;


# 7) EXIBIR O ATOR E A QUANTIDADE DE FILMES QUE ELE PARTICIPOU

select 
	concat(a.first_name, ' ', a.last_name) ator, count(*) quantidade_filmes
	from actor a 
	inner join film_actor fa 
		on fa.actor_id = a.actor_id 
	inner join film f 
		on f.film_id = fa.film_id
	group by a.actor_id;

# 8) EXIBIR O ATOR E A QUANTIDADE DE CATEGORIAS DE FILMES QUE ELE PARTICIPOU

select
	concat(a.first_name, ' ', a.last_name) nome, count( distinct fc.category_id) quantidade_categorias
	from actor a
		inner join film_actor fa 
			on fa.actor_id = a.actor_id
		inner join film_category fc 
			on fc.film_id = fa.film_id
	group by a.actor_id;
	


# 9) EXIBIR O FILME E A QUANTIDADE DO MESMO NO INVENTÁRIO DE CADA LOJA

select 
	f.title, count(*) quantidade_em_estoque, i.store_id 
	from film f 
	inner join inventory i 
		on i.film_id = f.film_id
	group by i.store_id, f.film_id 
	order by f.film_id;
	

# 10) EXIBIR O NOME DO CLIENTE QUE MAIS DEU LUCRO EM CADA LOJA

select 
	concat(c.first_name, ' ' ,c.last_name) nome , sum(amount) valor_gasto, c.store_id loja
	from customer c 
	inner join payment p
		on p.customer_id = c.customer_id
	group by c.customer_id
	order by valor_gasto desc
	limit 2;



# 11) EXIBIR O CLIENTE E O VALOR GASTO POR CADA UM DELES
# 12) EXIBIR O FILME E A QUANTIDADE DE VEZES QUE ELE FOI ALUGADO
# 13) EXIBIR O FILME E O VALOR QUE CADA UM ARRECADOU COM A LOCAÇÃO
# 14) EXIBIR O ID DA LOJA E A QUANTIDADE DE FILMES POR LOJA
# 15) EXIBIR TODOS OS FILMES QUE AINDA NÃO FORAM DEVOLVIDOS
# 16) EXIBIR O DIA E O VALOR RECEBIDO POR DIA
# 17) EXIBIR O VALOR RECEBIDO POR DIA EM CADA LOJA
# 18) EXIBIR O CLIENTE E A QUANTIDADE DE FILMES QUE ELE ALUGOU
# 19) EXIBIR O FILME, O ID DO INVENTÁRIO E QUANTIDADE DE VEZES QUE ELE FOI ALUGADO EM CADA LOJA
# 20) EXIBIR A QUANTIDADE DE FILMES ALUGADOS POR DIA EM CADA LOJA
# 21) EXIBIR A QUANTIDADE DE FILMES DEVOLVIDOS POR DIA EM CADA LOJA
# 22) EXIBIR A DATA E A QUANTIDADE DE FILMES ALUGADOS NAS SEXTAS-FEIRAS
# 23) EXIBIR O VALOR QUE DEVE SER RECEBIDO COM OS FILMES QUE AINDA NÃO FORA DEVOLVIDOS
# 24) EXIBIR O ID DA LOCAÇÃO, A DATA DE RETIRADA, A DATA DE DEVOLUÇÃO E A QUANTIDADE DE DIAS QUE OS FILMES FICARAM COM O CLIENTE
# 25) EXIBIR O DIA E O VALOR COM O MAIOR LUCRO
# 26) EXIBIR ORDENADAMENTE OS 5 ATORES COM A MAIOR QUANTIDADE DE PARTICIPAÇÕES EM FILMES
# 27) EXIBIR O FILME, O ID NO INVENTÁRIO E O VALOR QUE CADA UNIDADE GEROU DE LUCRO
# 28) EXIBIR O RANKING COM OS 10 CLIENTES QUE MAIS GERARAM LUCRO EM CADA LOJA
# 29) EXIBIR O RANKING COM OS 10 FILMES QUE MAIS GERARAM LUCRO EM CADA LOJA