import { Router } from 'express';

import { CreateUserController } from '../controllers/CreateUserController';

const usersRouter = Router();

const createUsersController = new CreateUserController();

usersRouter.post('/', createUsersController.create)

export {usersRouter};