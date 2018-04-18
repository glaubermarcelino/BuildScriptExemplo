using System;
using System.Linq;
using System.Collections.Generic;
using Core.Interfaces;
using Core.Models;

namespace Core.Fakes
{
    public class ProdutoFake : IProduto
    {
        private IList<ProdutoModel> _produtos;

        public ProdutoFake()
        {
            _produtos = new List<ProdutoModel>();
            _produtos.Add(GetNovoProduto(1, "Super Mega Bacon", "https://i.pinimg.com/originals/38/ab/b9/38abb9a249dbe32871bd11769642a306.jpg"));
            _produtos.Add(GetNovoProduto(2, "Hamburger de salmão", "http://cdn.crownmediadev.com/dims4/default/1de8fdb/2147483647/thumbnail/726x410%3E/quality/90/?url=http%3A%2F%2Fcdn.crownmediadev.com%2Ff8%2F107545b15cf140240754f17dbf330c%2FH%26F-Ep1147-Product-Laurie-Kilmartin.jpg"));
            _produtos.Add(GetNovoProduto(3, "Hamburger gourmet com fritas", "https://d2rw7fmapbgpu6.cloudfront.net/beta-sf608504prep.storefront.co.za/pictures/636505787240980458/a4-(300x500).jpg"));
            _produtos.Add(GetNovoProduto(4, "Hangover Sandwich", "https://d194ip2226q57d.cloudfront.net/images/7goodthings.2e16d0ba.fill-500x300.jpg"));
            _produtos.Add(GetNovoProduto(5, "X-Tudo", "http://www.misterpao.com.br/images/cardapio_lanche3.jpg"));
        }

        public IList<ProdutoModel> GetAll()
        {
            return _produtos;
        }

        public ProdutoModel GetById(int id)
        {
            return _produtos.Where(p => p.Id == id)
                            .FirstOrDefault();
        }

        private ProdutoModel GetNovoProduto(int id, string nome, string linkFoto)
        {
            return new ProdutoModel()
            {
                Id = id,
                Nome = nome,
                LinkFoto = linkFoto
            };
        }
    }
}
