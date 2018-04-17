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
    }
}
