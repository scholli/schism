
#include "target.h"

#include <algorithm>

namespace scm {
namespace inp {

target::target(std::size_t id)
  : _id(id),
    _transform(1.0f)
{
}

target::~target()
{
}

target::target(const target& ref)
  : _id(ref._id),
    _transform(ref._transform)
{
}

const target& target::operator=(const target& rhs)
{
    _id         = rhs._id;
    _transform  = rhs._transform;

    return (*this);
}

void target::swap(target& ref)
{
    std::swap(_id, ref._id);
    std::swap(_transform, ref._transform);
}

std::size_t target::id() const
{
    return (_id);
}

const math::mat4f_t& target::transform() const
{
    return (_transform);
}

void target::transform(const math::mat4f_t& trans)
{
    _transform  = trans;
}

} // namespace inp
} // namespace scm
