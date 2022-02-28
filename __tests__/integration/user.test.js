import { prisma } from "../../src/shared/infra/prisma/primaClient";
import request from "supertest";
import app from "../../src/shared/infra/http/app";

describe("User", () => {
  beforeEach(async () => {
    const deleteUsers = prisma.users.deleteMany();

    await prisma.$transaction(deleteUsers);
    console.log("users deleted!");
  });

  it("should be able to register", async () => {
    const response = await request(app).post("/users").send({
      name: "Flavio Rocha",
      email: "fmrocha@gmail.com",
      password_hash: "1223456",
    });

    expect(response.body).toHaveProperty("id");
  });

  it("should not be able to register with duplicated email", async () => {
    await request(app).post("/users").send({
      name: "Flavio Rocha",
      email: "fmrocha@gmail.com",
      password_hash: "123456",
    });

    const response = await request(app).post("/users").send({
      name: "Flavio Rocha",
      email: "fmrocha@gmail.com",
      password_hash: "123456",
    });

    expect(response.status).toBe(400);
  });
});
