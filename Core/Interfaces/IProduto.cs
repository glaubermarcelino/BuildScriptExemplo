using System;
using System.Collections.Generic;
using Core.Models;

namespace Core.Interfaces
{
    public interface IProduto
    {
        IList<ProdutoModel> GetAll();
        ProdutoModel GetById(int id);
    }
}
