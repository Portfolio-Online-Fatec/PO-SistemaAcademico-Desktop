import tkinter as tk
import tkinter.ttk as ttk
from tkinter import messagebox  # Importa messagebox para exibir mensagens ao usuário
from PIL import Image, ImageTk
import os
from alterar import ToplevelAlterar
from disciplina_backend import cadastrar_disciplina

class Toplevel1:
    def __init__(self, top=None):
        # Definir o tamanho da janela
        window_width = 1231
        window_height = 659

        # Calcular as coordenadas para centralizar a janela
        screen_width = top.winfo_screenwidth()
        screen_height = top.winfo_screenheight()
        x = (screen_width - window_width) // 2
        y = (screen_height - window_height) // 2

        # Configurações da janela principal
        top.geometry(f"{window_width}x{window_height}+{x}+{y}")
        top.minsize(120, 1)
        top.maxsize(1924, 1061)
        top.resizable(1, 1)
        top.title("Cadastrar Disciplina")
        top.configure(background="#d9d9d9")

        self.top = top

        # Adiciona um Canvas e desenha o gradiente de fundo
        self.canvas = tk.Canvas(self.top)
        self.canvas.pack(fill=tk.BOTH, expand=True)
        self.canvas.bind("<Configure>", self.update_gradient)

        # Cria os widgets da tela de cadastro
        self.create_widgets()

        # Desenha o título
        self.draw_title("Cadastrar Disciplina")
        
        self.add_small_image()
        
    def create_widgets(self):
        # Frame para os campos de entrada
        self.TFrame1 = tk.Frame(self.top, bg="white")
        self.TFrame1.place(relx=0.179, rely=0.228, relheight=0.581, relwidth=0.605)
        self.TFrame1.configure(relief='groove', borderwidth="2")

        # Carrega a imagem e coloca no frame central
        marca_page_path = os.path.join(os.path.dirname(__file__), 'imgs', 'marca_page.png')
        try:
            img_marca_page = Image.open(marca_page_path)
            img_marca_page = img_marca_page.resize((30, 100))  # Ajuste o tamanho se necessário
            img_marca_page_tk = ImageTk.PhotoImage(img_marca_page)

            label_img = tk.Label(self.TFrame1, image=img_marca_page_tk, bg="white")
            label_img.image = img_marca_page_tk  # Mantém referência para evitar garbage collection
            label_img.place(relx=0.05, y=0.0, anchor=tk.N)  # Ajuste a posição da imagem
        except Exception as e:
            print(f"Erro ao carregar a imagem marca_page.png: {e}")
            print(f"Tentando carregar imagem de: {marca_page_path}")

        # Campos de entrada
        self.label_disciplina = tk.Label(self.TFrame1, text='Disciplina:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_disciplina.place(relx=0.121, rely=0.078, height=21, width=64)
        self.txt_disciplina = ttk.Entry(self.TFrame1)
        self.txt_disciplina.place(relx=0.121, rely=0.131, relheight=0.055, relwidth=0.3)

        self.label_sigla = tk.Label(self.TFrame1, text='Sigla:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_sigla.place(relx=0.121, rely=0.235, height=21, width=35)
        self.txt_sigla = ttk.Entry(self.TFrame1)
        self.txt_sigla.place(relx=0.121, rely=0.287, relheight=0.055, relwidth=0.3)

        self.label_aulas_semanais = tk.Label(self.TFrame1, text='Aulas Semanais:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_aulas_semanais.place(relx=0.121, rely=0.392)
        self.txt_aulas_semanais = ttk.Entry(self.TFrame1)
        self.txt_aulas_semanais.place(relx=0.121, rely=0.444, relheight=0.055, relwidth=0.3)

        self.label_total_aulas = tk.Label(self.TFrame1, text='Total de Aulas(Semestre):', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_total_aulas.place(relx=0.121, rely=0.548, height=21, width=135)
        self.txt_total_aulas = ttk.Entry(self.TFrame1)
        self.txt_total_aulas.place(relx=0.121, rely=0.601, relheight=0.055, relwidth=0.3)

        self.label_carga_horaria = tk.Label(self.TFrame1, text='Carga Horária:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_carga_horaria.place(relx=0.121, rely=0.705, height=21, width=85)
        self.txt_carga_horaria = ttk.Entry(self.TFrame1)
        self.txt_carga_horaria.place(relx=0.121, rely=0.757, relheight=0.055, relwidth=0.3)

        self.label_ementa = tk.Label(self.TFrame1, text='Ementa:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_ementa.place(relx=0.564, rely=0.235, height=21, width=55)
        self.txt_ementa = tk.Entry(self.TFrame1)
        self.txt_ementa.place(relx=0.564, rely=0.287, height=210, relwidth=0.381)

        # Botão Cadastrar
        self.Button1 = tk.Button(self.TFrame1, text='Cadastrar', command=self.salvar_dados)
        self.Button1.place(relx=0.698, rely=0.888, height=26, width=77)

        # Botão para abrir a tela de alteração
        self.Button2 = tk.Button(self.top, text='Editar Disciplina', command=self.abrir_alterar_tela)
        self.Button2.place(relx=0.1, rely=0.9, anchor=tk.N, height=26, width=150)

        # Divisória mais fina
        self.divisoria = tk.Frame(self.TFrame1, bg="#2C5FA3")
        self.divisoria.place(relx=0.5, rely=0.5, relwidth=0.005, relheight=1, anchor=tk.CENTER)

    def update_gradient(self, event=None):
        width = self.canvas.winfo_width()
        height = self.canvas.winfo_height()
        self.draw_gradient(width, height)

    def draw_gradient(self, width, height):
        # Definindo as cores do gradiente
        start_color = "#26A7B9"
        end_color = "#331C8F"

        # Criar o gradiente no Canvas
        gradient = tk.PhotoImage(width=width, height=height)
        for i in range(height):
            r1, g1, b1 = self.hex_to_rgb(start_color)
            r2, g2, b2 = self.hex_to_rgb(end_color)
            r = int(r1 + (r2 - r1) * i / height)
            g = int(g1 + (g2 - g1) * i / height)
            b = int(b1 + (b2 - b1) * i / height)
            color = f'#{r:02x}{g:02x}{b:02x}'
            gradient.put(color, (0, i, width, i + 1))

        self.canvas.create_image(0, 0, anchor=tk.NW, image=gradient)
        self.canvas.image = gradient

        # Redesenha o título ao atualizar o gradiente
        self.draw_title("Cadastrar Disciplina")

    def draw_title(self, titulo):
        # Apaga o título anterior
        self.canvas.delete("titulo")
        
        width = self.canvas.winfo_width()
        x_position = width / 2  
        
        # Desenha o título diretamente no Canvas com um tamanho menor
        self.canvas.create_text(x_position, 50, text=titulo, font=("Montserrat", 25, "bold"), fill="white", tags="titulo")
   
    def add_small_image(self):
        logo_path = os.path.join(os.path.dirname(__file__), 'imgs', 'logo.png')
        try:
            small_img = Image.open(logo_path)
            small_img = small_img.resize((100, 50))  # Ajuste o tamanho se necessário
            small_img_tk = ImageTk.PhotoImage(small_img)
            # Adiciona a imagem ao frame inferior
            label_logo = tk.Label(self.top, image=small_img_tk, bg="#312593")  # Fundo igual ao da janela
            label_logo.image = small_img_tk  
            label_logo.place(relx=0.48, rely=0.85, anchor=tk.N)  # Ajuste a posição da imagem
        except Exception as e:
            print(f"Erro ao carregar a imagem logo.png: {e}")

    def salvar_dados(self):
        disciplina = self.txt_disciplina.get()
        sigla = self.txt_sigla.get()
        aulas_semanais = self.txt_aulas_semanais.get()
        total_aulas = self.txt_total_aulas.get()
        carga_horaria = self.txt_carga_horaria.get()
        ementa = self.txt_ementa.get()

        # Verifica se todos os campos estão preenchidos
        if not all([disciplina, sigla, aulas_semanais, total_aulas, carga_horaria, ementa]):
            messagebox.showerror("Erro", "Por favor, preencha todos os campos!")
            return

        # Chama a função para cadastrar a disciplina e obtém o resultado
        resultado = cadastrar_disciplina(disciplina, sigla, aulas_semanais, total_aulas, carga_horaria, ementa)

        # Exibe o resultado para o usuário
        messagebox.showinfo("Resultado", resultado)

        # Limpa os campos após o cadastro
        self.txt_disciplina.delete(0, tk.END)
        self.txt_sigla.delete(0, tk.END)
        self.txt_aulas_semanais.delete(0, tk.END)
        self.txt_total_aulas.delete(0, tk.END)
        self.txt_carga_horaria.delete(0, tk.END)
        self.txt_ementa.delete(0, tk.END)

    def abrir_alterar_tela(self):
        alterar_window = tk.Toplevel(self.top)
        ToplevelAlterar(alterar_window)

    @staticmethod
    def hex_to_rgb(value):
        # Converter uma cor hexadecimal para uma tupla RGB
        value = value.lstrip("#")
        return tuple(int(value[i:i + 2], 16) for i in (0, 2, 4))

if __name__ == "__main__":
    root = tk.Tk()
    app = Toplevel1(root)
    root.mainloop()