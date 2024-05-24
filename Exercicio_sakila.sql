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

select * from (
select 
	concat(c.first_name, ' ' ,c.last_name) nome , sum(amount) valor_gasto, c.store_id loja
	from customer c 
	inner join payment p
		on p.customer_id = c.customer_id
	where c.store_id = 1
	group by c.customer_id
	order by valor_gasto desc
	limit 1) as subq1
union
select * from (select 
	concat(c.first_name, ' ' ,c.last_name) nome , sum(amount) valor_gasto, c.store_id loja
	from customer c 
	inner join payment p
		on p.customer_id = c.customer_id
	where c.store_id = 2
	group by c.customer_id
	order by valor_gasto desc
	limit 1
)as subq2;


# 11) EXIBIR O CLIENTE E O VALOR GASTO POR CADA UM DELES

select 
	concat(c.first_name, ' ' ,c.last_name) nome , sum(amount) valor_gasto
	from customer c 
	inner join payment p
		on p.customer_id = c.customer_id
	group by c.customer_id
	order by valor_gasto desc;

# 12) EXIBIR O FILME E A QUANTIDADE DE VEZES QUE ELE FOI ALUGADO
	
select
	f.title, count(*) 
	from rental r 
		inner join inventory i 
			on i.inventory_id = r.inventory_id 
		inner join film f 
			on f.film_id = i.film_id 
	group by f.film_id;
			
# 13) EXIBIR O FILME E O VALOR QUE CADA UM ARRECADOU COM A LOCAÇÃO

select 
	f.title, sum(p.amount) total_rental_amount
	from payment p 
		inner join rental r 
			on p.rental_id = r.rental_id 
		inner join inventory i 
			on r.inventory_id = i.inventory_id 
		inner join film f 
			on i.film_id = f.film_id 
	group by f.film_id;
			
	
# 14) EXIBIR O ID DA LOJA E A QUANTIDADE DE FILMES POR LOJA

select 
	i.store_id , count(*)
	from inventory i 
	group by i.store_id; 

# 15) EXIBIR TODOS OS FILMES QUE AINDA NÃO FORAM DEVOLVIDOS

select 
	f.title, r.rental_date, i.inventory_id, r.return_date
	from rental r 
		inner join inventory i 
			on i.inventory_id = r.inventory_id 
		inner join film f 
			on i.film_id = f.film_id 
	where r.return_date is null;
			
# 16) EXIBIR O DIA E O VALOR RECEBIDO POR DIA

select 
	date(p.payment_date), sum(amount)
	from payment p
	group by date(p.payment_date)
	
	
# 17) EXIBIR O VALOR RECEBIDO POR DIA EM CADA LOJA
	
select 
	i.store_id, date(p.payment_date), sum(amount)
	from payment p 
		inner join rental r 
			on p.rental_id = r.rental_id 
		inner join inventory i 
			on r.inventory_id = i.inventory_id 
		group by i.store_id, date(p.payment_date)
		order by date(p.payment_date);

	
# 18) EXIBIR O CLIENTE E A QUANTIDADE DE FILMES QUE ELE ALUGOU
	
select 
	concat(c.first_name, ' ', c.last_name) nome, count(*) qtd_alugada
	from customer c 
		inner join rental r 
			on c.customer_id = r.customer_id 
	group by c.customer_id;
	
# 19) EXIBIR O FILME, O ID DO INVENTÁRIO E QUANTIDADE DE VEZES QUE ELE FOI ALUGADO EM CADA LOJA
	
select * from (select 
	f.title nome, group_concat(i.inventory_id) inventarios, count(*) qtd
	from rental r  
		inner join inventory i  
			on i.inventory_id = r.rental_id 
		inner join film f 
			on i.film_id = f.film_id 
	where i.store_id = 1
	group by f.film_id ) subq1
union 
select * from (select 
	f.title nome, group_concat(i.inventory_id) inventarios, count(*) qtd
	from rental r  
		inner join inventory i  
			on i.inventory_id = r.rental_id 
		inner join film f 
			on i.film_id = f.film_id 
	where i.store_id = 2
	group by f.film_id ) subq2;
	
# 20) EXIBIR A QUANTIDADE DE FILMES ALUGADOS POR DIA EM CADA LOJA

select * from (select 
	i.store_id loja, date(r.rental_date) dia, count(*) qtd_alugada
	from rental r
		inner join inventory i 
			on i.inventory_id = r.inventory_id 
	where i.store_id = 1
	group by date(r.rental_date)) subq1
union 
select * from (select 
	i.store_id loja, date(r.rental_date) dia, count(*) qtd_alugada
	from rental r
		inner join inventory i 
			on i.inventory_id = r.inventory_id 
	where i.store_id = 2
	group by date(r.rental_date)) subq2

# 21) EXIBIR A QUANTIDADE DE FILMES DEVOLVIDOS POR DIA EM CADA LOJA

select * from (select 
	i.store_id loja, date(r.return_date) dia, count(*) qtd_devolvida
	from rental r
		inner join inventory i 
			on i.inventory_id = r.inventory_id 
	where i.store_id = 1
	group by date(r.return_date)) subq1
union 
select * from (select 
	i.store_id loja, date(r.return_date) dia, count(*) qtd_devolvida
	from rental r
		inner join inventory i 
			on i.inventory_id = r.inventory_id 
	where i.store_id = 2
	group by date(r.return_date)) subq2
	
# 22) EXIBIR A DATA E A QUANTIDADE DE FILMES ALUGADOS NAS SEXTAS-FEIRAS
	
select 
	date(r.rental_date)	dia, count(*) qtd_devolvida
	from rental r
		inner join inventory i 
			on i.inventory_id = r.inventory_id 
	where dayofweek(r.rental_date) = 4
	group by date(r.rental_date);
	
	
# 23) EXIBIR O VALOR QUE DEVE SER RECEBIDO COM OS FILMES QUE AINDA NÃO FORA DEVOLVIDOS
	
select
	sum(f.rental_rate)
	from film f 
		inner join inventory i 
			on i.film_id = f.film_id 
		inner join rental r 
			on i.inventory_id = r.inventory_id 
	where r.return_date is null;
	
# 24) EXIBIR O ID DA LOCAÇÃO, A DATA DE RETIRADA, A DATA DE DEVOLUÇÃO E A QUANTIDADE DE DIAS 
# QUE OS FILMES FICARAM COM O CLIENTE
	
select 
	r.rental_id, r.rental_date, r.return_date, datediff(r.return_date,r.rental_date) dias
	from rental r ;
	
# 25) EXIBIR O DIA E O VALOR COM O MAIOR LUCRO
	
	select 
	date(p.payment_date), sum(amount) lucro
	from payment p 
		inner join rental r 
			on p.rental_id = r.rental_id 
		inner join inventory i 
			on r.inventory_id = i.inventory_id 
		group by i.store_id, date(p.payment_date)
		order by lucro desc
		limit 1;
	
# 26) EXIBIR ORDENADAMENTE OS 5 ATORES COM A MAIOR QUANTIDADE DE PARTICIPAÇÕES EM FILMES
	
select 
	concat(a.first_name, ' ', a.last_name) nome, count(*) qtd_filmes
	from actor a 
		inner join film_actor fa 
			on a.actor_id = fa.actor_id 
	group by a.actor_id
	order by qtd_filmes desc 
	limit 5;

# 27) EXIBIR O FILME, O ID NO INVENTÁRIO E O VALOR QUE CADA UNIDADE GEROU DE LUCRO

select * from
(select 
	f.title, group_concat(distinct i.inventory_id), sum(p.amount)
	from film f 
		inner join inventory i 
			on i.film_id = f.film_id 
		inner join rental r 
			on r.inventory_id = i.inventory_id 
		inner join payment p 
			on p.rental_id = r.rental_id
	where i.store_id = 1
	group by f.film_id) subq1
union
select * from
(select 
	f.title, group_concat(distinct i.inventory_id), sum(p.amount)
	from film f 
		inner join inventory i 
			on i.film_id = f.film_id 
		inner join rental r 
			on r.inventory_id = i.inventory_id 
		inner join payment p 
			on p.rental_id = r.rental_id
	where i.store_id = 2
	group by f.film_id) subq2;

# 28) EXIBIR O RANKING COM OS 10 CLIENTES QUE MAIS GERARAM LUCRO EM CADA LOJA

select 
	concat(c.first_name, ' ' ,c.last_name) nome , sum(amount) valor_gasto
	from customer c 
	inner join payment p
		on p.customer_id = c.customer_id
	group by c.customer_id
	order by valor_gasto desc
	limit 10;

# 29) EXIBIR O RANKING COM OS 10 FILMES QUE MAIS GERARAM LUCRO EM CADA LOJA

select 
	f.title, sum(p.amount) lucro
	from film f 
		inner join inventory i 
			on i.film_id = f.film_id 
		inner join rental r 
			on r.inventory_id = i.inventory_id 
		inner join payment p 
			on p.rental_id = r.rental_id
	group by f.film_id
	order by lucro desc 
	limit 10;
