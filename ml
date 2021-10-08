import scrapy

class MlSPider(scrapy.Spider):
    name = 'ml'

    start_urls = ['https://www.mercadolivre.com.br/ofertas']

    def parse(self, response, **kwargs):
        for i in response.xpath('//li[@class ="promotion-item"]'):
            price = i.xpath('.//span[@class ="promotion-item__price"]//text()').getall()
            title = i.xpath('.//p[@class="promotion-item__title"]/text()').get()
            link = i.xpath('./a/@href').get()

            yield{
                'price': price,
                'title': title,
                'link': link
            }

            next_page = response.xpath('//a[contains(@title, "Próxima")]/@href').get()
            if next_page:
                yield scrapy.Request(url=next_page, callback=self.parse)


"""    Criar projeto
    Primeiro pip install scrapy
    scrapy startproject nome_do_projeto
    cd nome_do_projeto
    scrapy genspider abreviação_do_projeto nome_do_site
    editar o settings
    comando pra rodar o scrapy e salvar no json pelo console #scrapy crawl ml -o starturls.json'
    

    start_urls = [f'https://www.mercadolivre.com.br/ofertas?page={i}' for i in range(1, 210)] #pega todas as paginas de ofertas do mercado livre, substituindo o I pelo loop de 1 até 209
    isso quando eu sei o total de páginas, se eu não sei, posso criar a variavel next_page
"""
