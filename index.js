const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const connection = require("./database/database");
const Pergunta = require("./database/Pergunta");
const Resposta = require("./database/Resposta");

connection
  .authenticate()
  .then(() => {
    console.log("Conexão feita com o banco de dados!");
  })
  .catch((msgErro) => {
    console.log(msgErro);
  });

app.use(express.static("public"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//Routes
app.get("/", (req, res) => {
  Pergunta.findAll({
    raw: true,
    order: [["id", "DESC"]],
  })
    .then((perguntas) => {
      res.json({ perguntas });
    })
    .catch((error) => {
      console.log(error);
     res.status(500).json({ error: error });
    });
});

app.get("/perguntar/:id", (req, res) => {
  var id = req.params.id;
  Pergunta.findOne({
    where: { id: id },
  })
    .catch((error) => {
      res.status(500).json({ error: error });
    })
    .then((pergunta) => {
      if (pergunta != undefined) {
        Resposta.findAll({
          where: { perguntaId: pergunta.id },
          order: [["id", "DESC"]],
        })
          .then((respostas) => {
            res.json({ pergunta, respostas });
          })
          .catch((error) => {
            res.status(500).json({ error: error });
          });
      } else {
        res.status(404).end();
      }
    });
});

app.post("/salvarpergunta", (req, res) => {
  var title = req.body.title;
  var description = req.body.description;

  Pergunta.create({
    title: title,
    description: description,
  })
    .then(() => res.status(201).end())
    .catch((error) => {
    res.status(500).json({ error: error });
    });
});

app.post("/responder", (req, res) => {
  var description = req.body.description;
  var perguntaId = req.body.perguntaId;
  Resposta.create({
    description: description,
    perguntaId: perguntaId,
  })
    .then(() => res.status(201).end())
    .catch((error) => {
      res.status(500).json({ error: error });
    });
});

app.listen(6147, () => {
  console.log("App rodando!");
});
