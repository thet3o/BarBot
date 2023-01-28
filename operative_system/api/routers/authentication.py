from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from api.models.token import Token
from api.models.user import User
from api.security.login import authenticate_user, create_access_token, get_current_active_user

ACCESS_TOKEN_EXPIRE_MINUTES = 30

authentication = APIRouter(
    prefix='/auth',
    tags=['authentication'],
    responses={404: {"description": "Not found"}},
)

@authentication.post('/token', response_model=Token)
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(data={'username': user.username,'sub': user.subject}, expires_delta=access_token_expires)
    return {"access_token": access_token, "token_type": "bearer"}

@authentication.get("/users/me")
async def read_users_me(current_user: User = Depends(get_current_active_user)):
    return current_user

@authentication.get("/users/test")
async def boss_users_me(current_user: User = Depends(get_current_active_user)):
    if current_user.subject != 'boss':
        raise HTTPException(status_code=401, detail="Not boss user")
    else:
        return {'ok': 'alright'}