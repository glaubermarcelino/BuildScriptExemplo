using System.Collections.ObjectModel;
using Core.Interfaces;
using Core.Models;
using Prism.Mvvm;

namespace Core.ViewModels
{
    public class HomeViewModel : BindableBase
    {
        public ObservableCollection<ProdutoModel> Produtos { get; private set; }

        private string _titulo;
        public string Titulo
        {
            get => _titulo;
            set => SetProperty(ref _titulo, value);
        }


        public HomeViewModel(IProduto produto)
        {
            Titulo = "Hamburgers";

            Produtos = new ObservableCollection<ProdutoModel>(
                produto.GetAll()
            );
        }
    }
}
