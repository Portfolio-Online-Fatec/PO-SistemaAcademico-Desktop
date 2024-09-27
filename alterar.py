import tkinter as tk
import tkinter.ttk as ttk
from tkinter import messagebox  # Importa messagebox para exibir mensagens ao usuário
from PIL import Image, ImageTk
import os
from disciplina_backend import editar_disciplina  # Importar a função de edição

class ToplevelAlterar:
    def __init__(self, top=None, dados=None):
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
        top.title("Editar Disciplina")
        top.configure(background="#d9d9d9")

        self.top = top
        self.dados = dados  # Dados da disciplina a serem alterados

        # Adiciona um Canvas e desenha o gradiente de fundo
        self.canvas = tk.Canvas(self.top)
        self.canvas.pack(fill=tk.BOTH, expand=True)
        self.canvas.bind("<Configure>", self.update_gradient)

        # Cria os widgets da tela de alteração
        self.create_widgets(dados)

    def create_widgets(self, dados):
        # Frame para os campos de entrada
        self.TFrame1 = tk.Frame(self.top, bg="white")
        self.TFrame1.place(relx=0.179, rely=0.228, relheight=0.581, relwidth=0.605)
        self.TFrame1.configure(relief='groove', borderwidth="2")

        # Carrega a imagem e coloca no frame central
        marca_page_path = os.path.join(os.path.dirname(__file__), 'imgs', 'marca_page.png')
        try:
            img_marca_page = Image.open(marca_page_path)
            img_marca_page = img_marca_page.resize((30, 100)) 
            img_marca_page_tk = ImageTk.PhotoImage(img_marca_page)

            label_img = tk.Label(self.TFrame1, image=img_marca_page_tk, bg="white")
            label_img.image = img_marca_page_tk  
            label_img.place(relx=0.05, y=0.0, anchor=tk.N)  # Ajuste a posição da imagem
        except Exception as e:
            print(f"Erro ao carregar a imagem marca_page.png: {e}")

        # Campos de entrada com os dados atuais
        self.label_disciplina = tk.Label(self.TFrame1, text='Disciplina:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_disciplina.place(relx=0.121, rely=0.078, height=21, width=64)
        self.txt_disciplina = ttk.Entry(self.TFrame1)
        self.txt_disciplina.place(relx=0.121, rely=0.131, relheight=0.055, relwidth=0.3)
        self.txt_disciplina.insert(0, dados['disciplina'])

        self.label_sigla = tk.Label(self.TFrame1, text='Sigla:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_sigla.place(relx=0.121, rely=0.235, height=21, width=35)
        self.txt_sigla = ttk.Entry(self.TFrame1)
        self.txt_sigla.place(relx=0.121, rely=0.287, relheight=0.055, relwidth=0.3)
        self.txt_sigla.insert(0, dados['sigla'])

        self.label_aulas_semanais = tk.Label(self.TFrame1, text='Aulas Semanais:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_aulas_semanais.place(relx=0.121, rely=0.392)
        self.txt_aulas_semanais = ttk.Entry(self.TFrame1)
        self.txt_aulas_semanais.place(relx=0.121, rely=0.444, relheight=0.055, relwidth=0.3)
        self.txt_aulas_semanais.insert(0, dados['aulas_semanais'])

        self.label_total_aulas = tk.Label(self.TFrame1, text='Total de Aulas(Semestre):', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_total_aulas.place(relx=0.121, rely=0.548, height=21, width=135)
        self.txt_total_aulas = ttk.Entry(self.TFrame1)
        self.txt_total_aulas.place(relx=0.121, rely=0.601, relheight=0.055, relwidth=0.3)
        self.txt_total_aulas.insert(0, dados['total_aulas'])

        self.label_carga_horaria = tk.Label(self.TFrame1, text='Carga Horária:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_carga_horaria.place(relx=0.121, rely=0.705, height=21, width=85)
        self.txt_carga_horaria = ttk.Entry(self.TFrame1)
        self.txt_carga_horaria.place(relx=0.121, rely=0.757, relheight=0.055, relwidth=0.3)
        self.txt_carga_horaria.insert(0, dados['carga_horaria'])

        self.label_ementa = tk.Label(self.TFrame1, text='Ementa:', font="Montserrat 8", bg="white", fg="#2C5FA3")
        self.label_ementa.place(relx=0.564, rely=0.235, height=21, width=55)
        self.txt_ementa = tk.Entry(self.TFrame1)
        self.txt_ementa.place(relx=0.564, rely=0.287, height=210, relwidth=0.381)
        self.txt_ementa.insert(0, dados['ementa'])

        # Botão Alterar
        self.Button1 = tk.Button(self.TFrame1, text='Alterar', command=self.alterar_dados)
        self.Button1.place(relx=0.698, rely=0.888, height=26, width=77)

        self.divisoria = tk.Frame(self.TFrame1, bg="#2C5FA3")
        self.divisoria.place(relx=0.5, rely=0.5, relwidth=0.005, relheight=1, anchor=tk.CENTER)

    def alterar_dados(self):
        # Coleta os dados dos campos
        id_disciplina = self.dados['id']  # A suposição é que o ID está nos dados
        disciplina = self.txt_disciplina.get()
        sigla = self.txt_sigla.get()
        aulas_semanais = self.txt_aulas_semanais.get()
        total_aulas = self.txt_total_aulas.get()
        carga_horaria = self.txt_carga_horaria.get()
        ementa = self.txt_ementa.get()

        # Chama a função de editar no backend
        resultado = editar_disciplina(id_disciplina, disciplina, sigla, aulas_semanais, total_aulas, carga_horaria, ementa)

        # Exibe o resultado
        messagebox.showinfo("Resultado", resultado)

        # Fecha a janela após a alteração
        self.top.destroy()

    def update_gradient(self, event=None):
        width = self.canvas.winfo_width()
        height = self.canvas.winfo_height()
        self.draw_gradient(width, height)

    def draw_gradient(self, width, height):
        start_color = "#26A7B9"
        end_color = "#331C8F"

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
        self.draw_title("Editar Disciplina")

    def draw_title(self, titulo):
        self.canvas.delete("titulo")
        width = self.canvas.winfo_width()
        x_position = width / 2  
        self.canvas.create_text(x_position, 50, text=titulo, font=("Montserrat", 25, "bold"), fill="white", tags="titulo")

    def hex_to_rgb(self, hex_color):
        hex_color = hex_color.lstrip('#')
        return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

if __name__ == "__main__":
    root = tk.Tk()
    root.mainloop()